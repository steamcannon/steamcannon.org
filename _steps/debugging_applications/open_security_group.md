---
title: Open Remote Debugging Port in Security Group
---

Before connecting a remote debugger to your application, you need to
first open a hole in a security group.

Find your IP address using a service like <http://whatismyip.org>, log
into AWS console, and open tcp port 8787 fo your IP address in the
steamcannon_jboss_as security group. Replace "123.123.123.123" with
your IP in the screenshot above but keep the "/32" on the end.
