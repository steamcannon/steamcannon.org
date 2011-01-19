---
title: How SteamCannon Compares to AWS Elastic Beanstalk
author: Ben Browning
layout: news
---

There's a lot of buzz today about Amazon's new [Elastic
Beanstalk][beanstalk] service. While Amazon doesn't directly come out
and say it, this is their Platform-as-a-Service offering so I thought
it would be good to provide a comparison between SteamCannon and AWS
Elastic Beanstalk. As the lead of the SteamCannon project my opinion
is biased but I will try to be as objective as possible.

[beanstalk]: http://aws.amazon.com/elasticbeanstalk/

Elastic Beanstalk is hosted by Amazon and manages environments on
Amazon's cloud. Thus, this comparison will concentrate on the hosted
version of SteamCannon at <https://try.steamcannon.org> that also
manages environments on Amazon's cloud. However, it is worth pointing
out that SteamCannon can run locally and, with version 0.3.0, manage
environments in VirtualBox as well as Amazon's cloud.

Because SteamCannon's next release is just a few weeks away, I will
reference features from both the current release (0.2.0) and the next
release (0.3.0). Any references to upcoming 0.3.0 features will be
marked as such for clarity.

### Signup Process

Elastic Beanstalk uses your existing AWS account so things are pretty
straightforward. Amazon does warn that some AWS accounts may require
additional verification to enable Elastic Beanstalk but in my case I
clicked the button and immediately received a confirmation email that
access had been granted.

SteamCannon requires an AWS account and a SteamCannon user account, so
you have an additional username / password to keep track of.

### New User Experience

Elastic Beanstalk provides a new user with the option to launch a
sample application or upload their own application. The sample
application is essentially a Hello World that contains links to useful
documentation and launched within a few minutes without any issues.

SteamCannon walks a new user through entering their AWS credentials
but otherwise doesn't provide a sample application for quickly
launching something. We do provide documentation for [Deploying Your
First Application][first_app] but it's not integrated into SteamCannon
itself.

[first_app]: /documentation/getting_started/deploying_first_app/

### Application Support

Elastic Beanstalk only supports Java applications packaged as .war
files that will run on Tomcat.

SteamCannon supports Java and Ruby applications packaged as .war,
.ear, .jar, .rails, .rack, or any other file that you can place in the
deploy/ directory of TorqueBox and JBoss AS6.

### Application URLs

Elastic Beanstalk provides a URL for each environment in the format of
http://<app_name>.elasticbeanstalk.com.

SteamCannon does not provide a consistent URL per-environment. An
environment's URL is just the public dns name of its mod_cluster EC2
instance.

### Application SSL Support

Elastic Beanstalk allows you to enable SSL support for an application
by uploading an SSL certificate using the AWS Access and Identity
Management service and then referencing that certificate in the
environment configuration.

SteamCannon does not provide SSL support for applications.

### Applications Per Environment

Elastic Beanstalk creates a new environment for every application.

SteamCannon allows multiple applications to be deployed
per-environment at different context paths. While not very useful for
small demo applications, in real-world usage it's quite common to
deploy more than one application to an application server.

### Instance Types

Elastic Beanstalk allows all EC2 instance types.

SteamCannon supports all EC2 instance types except the smallest,
t1.micro.

### Connecting to Instances

Both Elastic Beanstalk and SteamCannon let you choose an EC2 key pair
for connecting to instances via SSH.

### Platform Choices

Elastic Beanstalk only gives you one option right now - Tomcat servers
behind an Elastic Load Balancer.

SteamCannon provides three platform choices - a developer instance
running JBoss AS6 and PostgreSQL with debugging enabled, a two-tier
platform with mod_cluster and JBoss AS6 instances, and a three-tier
platform with mod_cluster, JBoss AS6, and PostgreSQL instances.

### JVM Options

Elastic Beanstalk lets you set JVM heap sizes and pass custom JVM
command-line options.

SteamCannon does not let you manually set JVM heap sizes or pass
custom JVM command-line options. Sensible defaults are chosen based on
the selected hardware profile.

### Database Options

Elastic Beanstalk provides a link to Amazon RDS documentation if your
application needs a database but Beanstalk does not handle any
provisioning or setup of the database. They also allow you to inject a
JDBC connection string as an environment variable per-environment so
you can use a single application in multiple environments where each
environment talks to a different database.

SteamCannon provides a PostgreSQL database option with a precreated
admin user and random password per environment. The database storage
is mounted on an EBS volume so its contents can survive an instance
restart. Instead of allowing injection of a JDBC connection string,
you can deploy a standard JavaEE datasource (*-ds.xml) file to the
environment with the connection details. Of course you can also use
Amazon RDS or any other cloud database by supplying the appropriate
parameters in a datasource file. You can deploy as many datasources in
a single environment as you need for applications that may talk to
multiple databases.

### Auto-Scaling

Elastic Beanstalk lets you configure various thresholds for starting a
new Tomcat server instance automatically.

SteamCannon has no auto-scaling. We do make it trivial to start
another server (a single button click) but it's not automatic.

### Clustering and Load Balancing

Elastic Beanstalk will load balance multiple Tomcat servers behind an
Elastic Load Balancer. However, the Tomcat servers are not clustered
with each other so your application can't rely on things like session
replication.

SteamCannon clusters and load-balances multiple TorqueBox / JBoss AS
servers behind a mod_cluster instance. The servers are clustered
together so session replication and caching work as expected within
the cluster.

### High Availability

Elastic Beanstalk allows you to start instances in separate
availability zones for physical separate of instances in case of an
outage or disaster.

SteamCannon requires all instances of an environment exist in the same
availability zone.

### Event Log

Both Elastic Beanstalk and SteamCannon provide detailed event logs
per-environment.

### Notifications

Elastic Beanstalk integrates with Amazon Simple Notification Service
for email-based alerts of important events.

SteamCannon has no notifications of events.

### Monitoring and Metrics

Elastic Beanstalk provides a visual indicator (green/yellow/red light)
of environment health and allows you to customize the application
health check URL. It also provides metrics about CPU usage, # of
requests, latency of requests, and other things via Amazon CloudWatch.

SteamCannon knows whether an instance is up or has died and whether an
application is deployed to an instance or not but it does not do
application-level health checks. It also doesn't provide any metrics.

### Log Viewing

Elastic Beanstalk allows you to view snapshots of logs from all Tomcat
servers as well as rotate log files hourly to Amazon S3.

SteamCannon lets you tail or view full logs from JBoss AS, PostgreSQL,
and mod_cluster but currently has no support for archiving log files
on S3.

### EC2 Region Support

Elastic Beanstalk only supports the us-east region at the moment but
have stated they plan to support other regions soon.

SteamCannon 0.2.0 only supports the us-east region but 0.3.0 adds
support for all EC2 regions.

### API

Both Elastic Beanstalk and SteamCannon(0.3.0) have comprehensive
APIs. Existing [Deltacloud] clients can be used with SteamCannon's
API for controlling instances inside a running environment.

[deltacloud]: http://deltacloud.org

### Final Thoughts

Elastic Beanstalk and SteamCannon are both in their early stages of
development and both have some pros and cons over the other. What
keeps me excited about SteamCannon regardless of the competition is
that we are a completely open-source stack with a goal of insulating
developers from the underlying cloud provider. We want a developer to
be able to take their application and deploy it just as easily to
their company's internal cloud as to Amazon's cloud and provide the
full JavaEE and Ruby platform developers expect.

We welcome any and all contributors of code or ideas and encourage you
to become part of our [community] to help steer our future direction
to meet your needs.

[community]: /community/
