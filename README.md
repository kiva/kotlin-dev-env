# Kotlin Demo Dev Environment

Demo Docker Compose setup for local development using demo apps.

If you haven't yet, follow our [guide on Confluence](https://confluence.kiva.org/display/BRAIN/Kotlin+Developer+Setup) to set up 
your local development environment and install dependencies.

The individual repos may be found at:
* https://github.com/kiva/nuxt-sandbox
* https://github.com/kiva/schema-stitching-demo
* https://github.com/kiva/kotlin-demo

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

Use Docker Compose to build and run your environment. Note that many apps boot in development mode, meaning they
will compile and reflect the local state of your individual repositories. Thus if you haven't pulled in updates to those
repos lately, you might run into some issues.

```
# From the kotlin-dev-env directory

docker-compose build

docker-compose up
```

You'll see console output relative to each service. Because the Kotlin app can be slow to boot in development  mode,
and the Apollo GraphQL server has exponential backoff, it can take a while before the `api` service finally reports that
it has started.

To test everything out, try the following in your browser:

- UI server: `http://localhost:8989/`
- Apollo GraphQL server: `http://localhost:3000/graphiql`
- Kotlin app: `http://localhost:8080/graphiql?query=%7B%0A%20%20version%0A%7D`

## Notes on Container Boot Timing and Runtime Exceptions

Docker Compose doesn't directly allow you to coordinate container startup -- and that's a good thing. Our real services
will need to be robust enough to start up even if their dependencies are unavailable.

However, the current state of our apps means that there can be failures if some containers don't boot fast enough.

In particular, the Kotlin demo will fail to boot if it cannot connect to the DB, and the Apollo graphQL server will fail
to boot if the Kotlin demo app is not available.

In most cases, just stopping all containers and trying again works. If you're having particular problems with coordinating
the timing of the Kotlin app boot vs the Apollo graphQL server boot, you can try tweaking the NUM_RETRIES environment variable
defined in the graphql service in docker-compose.yml.

## Data Persistence

Currently the database's lifetime is tied to the DB container. The source repo for the image (https://github.com/sameersbn/docker-mysql)
has some notes on how to mount a permanent database as a volume. This is not currently a priority due to the obvious ephemeral
demo nature of the whole stack, but it wouldn't be too difficult to add. (In fact, the 0-version of the docker compose setup did
exactly that.)

# Local Code Updates and Hot Restarts

The Docker Compose configuration boots the UI server, the Apollo GraphQL server, and the Kotlin service in development
modes that support hot restarts.

However, the UI server and Apollo GraphQL servers require npm installed locally to properly support hot restarts. Rather
than require npm installation, we have opted to simply avoid fully supporting hot restarts via the current
configuration. If you have npm installed locally, it's not too difficult to alter the configuration to mount
your source repositories in the respective services, and follow the READMEs to compile locally.

The Kotlin service will trigger auto restarts upon compilation updates, which can be triggered by local Gradle builds.
Alternatively, if a source file has changed, re-running `docker-compose up` will cold restart the service, triggering
compilation.

Finally, you can always just re-run `docker-compose build` to push local updates to the images powering the services, and
follow up with `docker-compose up`.