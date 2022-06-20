# Mini Shop

Mini Shop is a basic e-commerce solution built with Ruby on Rails 6.0

## Demo

You can view the demo deployed to heroku at [https://minishopdemo.herokuapp.com](https://minishopdemo.herokuapp.com).

#### Admin Credentials

You can login to the admin dashboard using the *Email* admin@example.com and *Password* testing1234

## Development Setup

Run the following commands to setup the Rails app in your local machine.

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
