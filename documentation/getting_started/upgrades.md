---
layout: default
title: Upgrading and Migrating Your SteamCannon Appliance
sections:
  - Documentation
  - Getting Started
---

The easiest path for upgrading a SteamCannon appliance is to launch an instance of the new AMI and 
use the SteamCannon migration script to move your data to the new instance.

1. Launch a new instance of SteamCannon. You will migrate your existing instance to this machine.
1. Copy the **private** DNS name for the new instance that you just launched.
1. SSH to your existing instance and change directories to /opt/steamcannon/bin
1. Run ./migrate.sh private.dns.of.new.instance.com
1. SSH to your new instance 
1. Execute the following commands
    
    $ cd /opt/steamcannon
    
    $ RAILS_ENV=production /opt/jruby/bin/jruby -S rake db:migrate
    
    $ RAILS_ENV=production /opt/jruby/bin/jruby -S rake db:seed

1. You're Done!