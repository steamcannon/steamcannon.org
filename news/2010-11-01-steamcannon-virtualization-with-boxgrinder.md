---
title: SteamCannon Virtualization with BoxGrinder
author: Lance Ball
layout: news
sequence: 4
---
[boxgrinder]: http://www.jboss.org/boxgrinder.html
[boxgrinder forums]: http://community.jboss.org/en/boxgrinder?view=discussions
[steamcannon lists]: http://steamcannon.org/community/mailing_lists/
[appliance definition file]: http://community.jboss.org/wiki/BoxGrinderBuildApplianceDefinitionFile
[steamcannon appliance definition]: http://github.com/steamcannon/steamcannon-appliances/blob/1.0.0.beta1/appliances/steamcannon.appl
[steamcannon-appliances]: http://github.com/steamcannon/steamcannon-appliances
[appliance definitions]: http://github.com/steamcannon/steamcannon-appliances/tree/1.0.0.beta1/appliances
[steamcannon-meta.appl]: http://github.com/steamcannon/steamcannon-appliances/blob/1.0.0.beta1/appliances/steamcannon-meta.appl

SteamCannon simplifies the deployment of PaaS environments by making pre-rolled machine images 
and deployment platforms - built with [BoxGrinder][] - available for your J2EE and Rails applications.  Together, a set of one
or more of these images is known as an Environment in SteamCannon. An environment is a discrete, 
named instance of a PaaS, encapsulating your database, application server(s), load balancers and other services 
required by your applications.  When setting up a new environment in SteamCannon you'll be able to choose from 
a few pre-defined platforms and their images.  Out of the box, we provide developer, 2-tier and 3-tier environments.  

<img src="/images/new-environment.png" title="Define a new environment"/>

## Machine Images in SteamCannon Environments

Each deployed machine instance in the environment corresponds to a single Fedora 13 machine image 
pre-rolled to include everything required to support its exposed services.  We build these images 
using [BoxGrinder][].  BoxGrinder helps make SteamCannon possible by providing tools that make it easy to 
define and grind out machine images for various virtualization platforms including Virtual Box, VMWare and 
Amazon AWS.  EBS-backed AMIs are the output of choice for production-level consumption, but BoxGrinder can also 
churn out S3-stored AMIs, VMware and Virtual Box images, and raw machine files.

## How SteamCannon Uses BoxGrinder Images

Creating a machine image with BoxGrinder is done with command-line tools and an [appliance definition file][] in which you specify
how you'd like to grind your image.  This specification includes basic metadata such as name and version; hardware information such as disk 
partitions and memory allocation; any RPM packages you'd like the machine to be baked with, and perhaps most usefully,
any shell-based commands you'd like to run when the machine launches.

We found that using BoxGrinder to create virtual appliances was incredibly useful - so much so that we're eating our own 
dog food, as it were. SteamCannon itself is [shipped](/download) as an Amazon Machine Image built with BoxGrinder. This is arguably the 
easiest way to get a fully functional SteamCannon installation up and running.  

By packaging SteamCannon as an RPM, we can automate the installation of our app onto a BoxGrinder image so that deployment becomes 
nothing more than launching an Amazon AMI. In fact, this is how we deploy SteamCannon on [try.steamcannon.org](http://try.steamcannon.org).

As machine images go, SteamCannon's is fairly straightforward. In the [SteamCannon appliance definition][] file we've specified
Fedora 13 as the base operating system, a 5GB root partition, a couple gigs of RAM, and a basic set of RPMs, including SteamCannon
itself, PostgreSQL and [DeltaCloud](http://deltacloud.org/). In the post section, which is run when the machine image is launched,
we configure the database, add some swap space, and initialize SteamCannon.  This simple file makes it possible for us to produce
a fully functional SteamCannon deployment with a single BoxGrinder command.

    $ boxgrinder-build appliances/steamcannon.appl -p ec2 -d ebs
  
BoxGrinder is an incredibly powerful tool that helps developers and system administrators reliably churn out fully customized
virtual machine images.  With the release of SteamCannon Beta1, we've produced several [appliance definitions][] which may be helpful
references of real-world usage, when you're getting started with BoxGrinder.  And if you you want to build your own
SteamCannon appliance from scratch, we even found it useful to create a machine image specifically customized for building the 
SteamCannon platform, [steamcannon-meta.appl][].  It's turtles all the way down.

## Where to Learn More

If you're interested in learning more about BoxGrinder, head on over to the [BoxGrinder] pages on JBoss.org.  Marek Goldmann
who heads up that project has produced lots of good documentation.  To learn more about how SteamCannon uses BoxGrinder, check
out the [steamcannon-appliances][] repository on GitHub.

Finally, join our mailing lists and read our forums.

  * [BoxGrinder forums][]
  * [SteamCannon lists][]

