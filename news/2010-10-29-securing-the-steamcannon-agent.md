---
title: Securing the SteamCannon Agent
author: Toby Crawley
layout: news
sequence: 1
---

On each instance that SteamCannon spins up, we have a small Sinatra
based [agent](http://github.com/steamcannon/steamcannon-agent) that
allows us to monitor, configure, and deploy to the services on the 
instance (JBoss AS, PostgreSQL, etc). Since these instances can be
running in different cloud provider accounts than the SteamCannon
instance, this agent has to be exposed to the internet at large.

We had three security issues with the SteamCannon <--> agent
communication that we needed to solve:

1. All communication between SteamCannon and the agent needs to be
   encrypted.
2. SteamCannon needs to know that the agent it is talking to is one
   that it actually launched.
3. The agent needs to know that the SteamCannon that is issuing it
   commands is the one that launched it.

The solution to #1 is easy - SSL! #2 and #3 require a shared secret
between SteamCannon and the agent. But for that secret to remain a 
secret, it cannot be transmitted in the clear. 

In order to solve this problem, we discussed several approaches before 
coming up with what we call the 'SSL Dance'.

The SSL Dance has the following steps:

1. Each SteamCannon generates its own CA and client certificates on 
   first boot.
2. When SteamCannon launches an instance, it passes its CA certificate 
   to the new instance via the [user-data](http://docs.amazonwebservices.com/AWSEC2/latest/DeveloperGuide/index.html?AESDG-chapter-instancedata.html#instancedata-user-data-retrieval) blob.
3. When the instance boots, it launches the agent, which generates its 
   own self-signed server certificate, and listens on a secure port with 
   client certificate authentication enabled.
4. SteamCannon polls the agent port on the instance until it responds to 
   a status call. This call is made with certificate validation disabled 
   (since the agent currently presents a self signed certificate), and 
   SteamCannon presents its own client certificate.
5. The agent responds that it has started (It will only respond to a 
   request that presents a client certificate that was signed by the 
   CA certificate it was given at boot time, which is unique to the 
   SteamCannon that launched it).
6. SteamCannon then generates a new server certificate for the agent, 
   signed with its own CA. SteamCannon posts this new certificate and 
   keypair to the agent, authenticating with its client certificate 
   (with certificate validation again disabled, since the agent will 
   still present a self-signed certificate).
7. The agent receives the new certificate and keypair, and restarts after 
   configuring itself to use the new certificate (that has been signed by
   the SteamCannon's CA) instead of the self-signed one.
8. SteamCannon polls the agent, waiting for it to come back up after 
   restarting, and authenticates its requests with its client certificate. 
   However, it does turn on certificate validation, expecting the 
   certificate presented by the agent to be signed by its own CA.

For the more visually inclined, here are the dance steps in a 
diagram (click it for a larger version):
<a href="/images/ssl_dance.png" target="_blank"><img alt="Ladder Diagram" src="/images/ssl_dance.png" width="550"/></a>

Once the agent has been verified as being properly configured, 
SteamCannon can make requests to the instance (via the agent), 
and be confident that it is an instance that the
SteamCannon launched. The agent can receive requests, and be 
confident they come from the SteamCannon that launched the agent's
instance.


