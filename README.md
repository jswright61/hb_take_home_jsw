# README

This is a take-home project for a HoneyBadger job application submitted by Scott Wright.
It is built using Ruby 3.2.0 and Rails 7.4.1
It has an external dependancy of the HTTP gem.
The assignment was to create a production-ready endpoint to receive a JSON payload and
notify a Slack channel if the payload met specified criteria.

# WARNINGS

## THIS PROJECT IS NOT PRODUCTION READY for the following explicit reasons and others not mentioned:

1. There is no security on the endpoint (or the application in general) therefor this application
   CANNOT BE SAFELY DEPLOYED to a routable, reachable internet address.

1. This application uses rails ActiveJob with no third party queueing adapter and thus is at high
   risk of losing jobs.

1. This applications uses SQLite even in production - SQLite is not a good choice for a prouction data store.

1. Due to the time constraints, there are no tests.

1. Without knowing your security architeceture for storing sensitive data, I opted to put
   sensitive data in config/secrets.yml. This is not a modern recommended way to store sensitive
   data for many reasons, not the least of which is that it is not encrypted at rest.

# To run this project

1. Clone the repo into it's own directory on the machine you wish to run it on

1. Copy config/secrets.example.yml to config/secrets.yml and then provide your sensitive data
   `$ cp config/secrets.example.yml config/secrets.yml`

1. Update the values for properly scoped bearer token and the channel id of the channel to receive alerts in secrets.yml

1. Spin up a Rails Server in development mode
   `$ rails server`

To run it in a production environment I recommend running the rails server as a Daemon on a local (unexposed) port and configuring a reverse proxy server such as Nginx to serve requests on port 443 from the local (unexposed) port.

# Design decisions

1. I opted to use a DelayedJob to make the slack notification because I never want an app's response time dependent on
   an external API.

1. I save the incoming Bounces to a database - if it's importent enough to alert a whole Slack channel, it's worth
   saving them plus it provides for easy async job as well as a convenient way to make sure the alert is fired only once.
