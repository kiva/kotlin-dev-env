# Kotlin Demo Dev Environment

Demo Docker Compose setup for local development using demo apps.

Note: This is a clunky setup process for demo purposes. If you'd like to improve the process, please do so!

# Install Demo Apps

First, clone this repo into a directory on your Mac:

```
git clone git@github.com:kiva/kotlin-dev-env.git
```

Next, run a script to install all demo app repos as siblings alongside this repo:

```
cd kotlin-dev-env/
./install_demo_repos.sh
```

# Docker Compose

Dependency: You'll want to have Docker and Docker Compose installed locally. ([Docker for Mac](https://www.docker.com/docker-mac) includes Docker Compose.)

Finally, test your environment via Docker Compose:

```
# From the kotlin-dev-env directory

docker-compose build

docker-compose up
```

## Notes on Container Boot Timing and Runtime Exceptions

Docker Compose doesn't directly allow you to coordinate container startup -- and that's a good thing. Our real services
will need to be robust enough to start up even if their dependencies are unavailable.

However, the current state of our apps means that there can be failures if some containers don't boot fast enough.

In particular, the Kotlin demo will fail to boot if it cannot connect to the DB, and the Apollo graphQL server will fail
to boot if the Kotlin demo app is not available.

In most cases, just stopping all containers and trying again works. If you're having particular problems with coordinating
the timing of the Kotlin app boot vs the Apollo graphQL server boot, you can try tweaking the DELAY_TIME environment variable
defined in the graphql service in docker-compose.yml.


## Data Persistence

Currently the database's lifetime is tied to the DB container. The source repo for the image (https://github.com/sameersbn/docker-mysql)
has some notes on how to mount a permanent database as a volume. This is not currently a priority due to the obvious ephemeral
demo nature of the whole stack, but it wouldn't be too difficult to add. (In fact, the 0-version of the docker compose setup did
exactly that.)
