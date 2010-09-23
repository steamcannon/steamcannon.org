---
title: Using Pre-Signed URLs With S3_PING
author: Ben Browning
layout: news
---

# What is S3_PING?

S3_PING is a protocol in [JGroups][] that allows nodes running in EC2
to discover each other without needing multicast (which is disabled in
EC2). Previously, S3_PING was configured on each node by putting
your AWS credentials in an XML file.

[jgroups]: http://jgroups.org

# What are S3 Pre-Signed URLs?

In S3, pre-signed URLs are a way to temporarily authenticate via query
string parameters instead of http headers. The most common use-case is
when you have a bucket that requires authentication but want to give
someone else access to resources in that bucket for a specified period
of time. See Amazon's [REST Authentication][] docs for the technical
details.

[rest authentication]: http://s3.amazonaws.com/doc/s3-developer-guide/RESTAuthentication.html

# Putting Them Together

The downside of S3_PING is that you have to place your AWS credentials
in a configuration file on every node of a cluster. For SteamCannon,
we wanted a way to manipulate resources in protected S3 buckets that
didn't involve passing our credentials around to individual
nodes. Luckily, that's exactly what S3 Pre-Signed URLs provide!

We worked closely with Bela Ban from the JGroups team and implemented
this as [JGRP-1235][] which will be in the upcoming JGroups 2.10.1 and
2.11 releases. Now, instead of passing credentials around, you pass
around unique URLs for each node in the cluster. If one of the URLs
get compromised, an attacker would only have access to that single S3
resource instead of the keys to your entire AWS account.

[JGRP-1235]: https://jira.jboss.org/browse/JGRP-1235

# Client Library Support For Pre-Signed URLs

One problem we ran into was that all the S3 client libraries we found
only supported pre-signed URLs for GET requests. So, we've contributed
two implementations back to the community - one in Ruby and one in
Java.

### Ruby

We've [forked][sc_s3] the [S3][s3_gem] Ruby gem and added support for
pre-signed URLs with any HTTP verb. Until the changes are pushed
upstream, you can play with pre-signed URLs by installing the
steamcannon-s3 gem.

    gem install steamcannon-s3

The new method is [S3::Signature.generate_temporary_url][sc_s3_rdoc].

[sc_s3]: http://github.com/steamcannon/s3
[s3_gem]: http://github.com/qoobaa/s3
[sc_s3_rdoc]: http://rubydoc.info/github/steamcannon/s3/master/S3/Signature.generate_temporary_url

### Java

For Java, we added a static helper method to the S3_PING class inside
JGroups. Since the updated JGroups hasn't been released yet, here's a
[gist][s3_ping_gist] of the method documentation and signature.

[s3_ping_gist]: http://gist.github.com/594467
