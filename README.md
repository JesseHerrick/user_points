# UserPoints Code Exercise

This Phoenix app is an exercise in building an API endpoint to query for no more than two users with points more than a random `max_number` set every minute in the `PointsHandler` GenServer. It periodically resets the random points on 100 different users along with the global `max_number` within the `PointsHandler` GenServer.

## Requirements

The following requirements are also listed in the `.tool-versions` file for
[asdf](https://github.com/asdf-vm/asdf) users. If you already have asdf
installed, simply run `asdf install` in the project root.

This project was built against the following versions of Elixir, Erlang, and Node.js:

* Elixir 1.11.3
* Erlang 23.2.6
* Node.js 14.12.0

PostgreSQL v12.5 was also used, which can be installed via Homebrew, your package manager of choice, or Docker.

## Quick Start

1. Clone and `cd` into the repo: `git clone https://github.com/JesseHerrick/user_points.git && cd user_points`
2. Install mix dependencies: `mix deps.get`
3. Install node dependencies: `npm install --prefix assets`
4. Create and seed the database with initial users: `mix ecto.setup`
5. Start the server: `mix phx.server`
6. Visit [`localhost:4000`](http://localhost:4000) in your browser.

## Running Tests

Tests may be run with `mix test`.

## Code Documentation

Documentation can be found throughout the repo. To build and view the docs locally, run the following (after installing all dependencies): `mix docs && open doc/index.html`.