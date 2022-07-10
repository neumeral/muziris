# Muziris

Muziris is a basic e-commerce solution built with Ruby on Rails 6.x

This is a fork of Mini Commerce (https://github.com/internetmango/mini_commerce).

It is named after the port city of [Muziris](https://en.wikipedia.org/wiki/Muziris). Muziris was an ancient port in Malabar coast, that was the hub of spice trade in ancient Kerala.

## Demo
(coming soon)

#### Admin Credentials

You can login to the admin dashboard using the *Email* admin@example.com and *Password* testing1234

## Development Setup

Run the following commands to setup the Rails app in your local machine.
Assumes NodeJS v14.x is installed in your system, with Yarn 1.22

```sh

bundle install
yarn install 

bundle exec rails db:migrate
bundle exec rails db:seed

bundle exec rails server
```

## Running Tests

Run RSpec by running the following command

```
bundle exec rspec
```

## Deploying

- Change the environment variables in `config/env.yml`, or set it to your servers ENV
- Change encrypted credentials, find the sample keys at `config/credentials.yml.sample`


## Contributing

Coming Soon

## License
MIT Licensed
