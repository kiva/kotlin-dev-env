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

## Data Persistence

Currently the database's lifetime is tied to the DB container. The source repo for the image (https://github.com/sameersbn/docker-mysql)
has some notes on how to mount a permanent database as a volume. This is not currently a priority due to the obvious ephemeral
demo nature of the whole stack, but it wouldn't be too difficult to add. (In fact, the 0-version of the docker compose setup did
exactly that.)
