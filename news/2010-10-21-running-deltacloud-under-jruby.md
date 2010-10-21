---
title: Running Deltacloud Under JRuby
author: Ben Browning
layout: news
---

[Deltacloud][] is used extensively in SteamCannon. However, Deltacloud
was originally written to target MRI and SteamCannon runs on
[JRuby][]. We've worked with the Deltacloud team to get the latest
trunk working under JRuby and will continue to do so to ensure future
compatibility.

For the sake of other JRubyists, here's a quick guide to getting
Deltacloud up and running.

[deltacloud]: http://deltacloud.org
[jruby]: http://jruby.org

# Build and Install the JRuby Deltacloud Gems

Deltacloud hasn't made an official release of the JRuby-compatible
gems yet, so first we need to download the sources and build them.

    $ git clone git://git.apache.org/deltacloud.git
    $ cd deltacloud/server
    $ jruby -S rake package
    $ cd ../client
    $ jruby -S rake package

The latest Deltacloud gems are now built under server/pkg and
client/pkg. Let's install the JRuby versions of each.

    $ cd ../
    $ jruby -S gem install server/pkg/deltacloud-core-*-java.gem
    $ jruby -S gem install client/pkg/deltacloud-client-*-java.gem


# Running Deltacloud From the Command-line

To test that everything worked, fire up the server with the mock driver.

    $ jruby -S deltacloudd -i mock
    Starting Deltacloud API :: mock :: http://localhost:3001/api

    => Ctrl-C to shutdown server
    [2010-10-21 09:16:43] INFO  WEBrick 1.3.1
    [2010-10-21 09:16:43] INFO  ruby 1.8.7 (2010-09-28) [java]
    [2010-10-21 09:16:43] INFO  WEBrick::HTTPServer#start: pid=5041 port=3001

Now, in another terminal, connect with the command-line client and
verify that it can talk to the server.

    $ jruby -S deltacloudc -u "http://localhost:3001/api" realms index
    us         | United States   | AVAIL |            GB
    eu         | Europe          | AVAIL |            GB

Fire up a web browser and point it at <http://localhost:3001/api> to
test the web interface.

# Running Deltacloud Within TorqueBox

SteamCannon runs on top of [TorqueBox][], so naturally we run
Deltacloud inside it instead of from the command-line. All that's
needed to run Deltacloud is to place a deltacloud-rack.yml file inside
TorqueBox's deploy directory.

[torquebox]: http://torquebox.org

    $ cat << EOF > $JBOSS_HOME/server/default/deploy/deltacloud-rack.yml
    ---
    application:
      RACK_ROOT: $JRUBY_HOME/lib/ruby/gems/1.8/gems/deltacloud-core-0.0.8-java
      RACK_ENV: production
    web:
      context: /deltacloud
    environment:
      API_DRIVER: mock
    EOF

Make sure `deltacloud-core-0.0.8` matches the version of the
deltacloud-core gem that's installed. Start TorqueBox and point a
browser to <http://localhost:8080/deltacloud/api> to test things out.
