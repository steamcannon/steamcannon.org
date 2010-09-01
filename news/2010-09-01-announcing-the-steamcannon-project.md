---
title: Announcing the SteamCannon Project
author: Ben Browning
layout: news
---
# What is SteamCannon?

SteamCannon is an application for creating and managing a JavaEE
Platform-as-a-Service. It's written in Ruby, runs on top of
[TorqueBox](http://torquebox.org), and uses [Deltacloud](http://deltacloud.org)
to target multiple cloud fabrics.

It consists of two components - a management console and an agent.

# Management Console

The SteamCannon management console is the interface for interacting
with your PaaS. From here you upload, deploy, and manage your
applications and the environments they run in.

# Agent

The SteamCannon agent is a Sinatra application running on every
instance. The management console talks to the agent to start and
stop services, deploy and undeploy applications, and keep an eye
on overall status of services and deployments.

# Relationship to CoolingTower

The CoolingTower project was the previous, unofficial name of
SteamCannon. There may still be references to CoolingTower on
various sites but everything will be transitioning to the
SteamCannon name.
