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

1. This applications uses SQLLite even in production - SQLLite is not a good choice for a prouction data store.

1. The tests in this project are insufficient for a production application.

1. Without knowing your security architeceture for storing sensitive data, I opted to put
   sensitive data in config/secrets.yml. This is not a modern recommended way to store sensitive
   data for many reasons, not the least of which is that it is not encrypted at rest.

# To run this project

1. Clone the repo into it's own directory on the machine you wish to run it on

1. Copy config/secrets.example.yml to config/secrets.yml and then provide your sensitive data
   `$ cp config/secrets.example.yml config/secrets.yml`

1. Spin up a Rails Server in development mode
   `$ rails server`

To run it in a production environment I recommend running the rails server as a Daemon on a local (unexposed) port and configuring a reverse proxy server such as Nginx to server requests on port 443 from the local (unexposed) port
