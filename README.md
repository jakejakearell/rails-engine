# Rails Engine

Mention about using bcrypt for protecting user data and how it's in gemfile and configuration. If you want to use another tool do this to pull it out.

## Authors

* **Jacob Arellano** -- [GitHub](https://github.com/jakejakearell) |
  [LinkedIn](https://www.linkedin.com/in/jacob-arellano-ab2890207/)

    See also the list of
    [contributors](https://github.com/jakejakearell/rails-engine/contributors)
    who participated in this project.


## Summary

  - [Getting Started](#getting-started)
  - [Database Normalization](#database-normalization)
  - [Running the test suite](#running-the-test-suite)
  - [Deployment](#deployment)
  - [Built With](#built-with)
  - [How to Contribute](#how-to-contribute)
  - [Roadmap](#roadmap)
  - [Contributors](#contributors)
  - [Acknowledgments](#acknowledgments)

## Getting Started

These instructions will get you a copy of the project up and running on
your local machine for development and testing purposes. See deployment
for notes on how to deploy the project on a live system.

### Prerequisites

* __Ruby__

  - The project is built with rubyonrails using __ruby version 2.5.3p105__, you must install ruby on your local machine first. Please visit the [ruby](https://www.ruby-lang.org/en/documentation/installation/) home page to get set up. Please ensure you install the version of ruby noted above.

* __Rails__
  ```sh
  gem install rails --version 5.2.4.3
  ```

* __Postgres database__
  - Visit the [postgresapp](https://postgresapp.com/downloads.html) homepage and follow their instructions to download the latest version of Postgres.app.


### Installing

1. Clone the repo
   ```sh
   git clone https://github.com/harrison-blake/viewing_party
   ```

2. Bundle Install
   ```sh
   bundle install
   ```

3. Create rails database and migrate
   ```sh
   $ rails db:create
   $ rails db:migrate
   ```

4. Start rails server
    ```sh
    $ rails s
    ```
## Database Normalization
**Jacob**
### DB Schema

[Database Design](insertlinkhere)

## Running the test suite
```sh
$ rails bundle exec rspec
```
The tests are all built using the [RSpec](https://rspec.info/) and [Capybara](https://github.com/teamcapybara/capybara) test suites.


## Endpoints

Add additional notes about how to deploy this on a live system
**Harrision**

## Deployment

Add additional notes about how to deploy this on a live system
**Harrision**

## Built With

  * [Ruby on Rails](https://rubyonrails.org)
  * [HTML](https://html.com)

## Roadmap

See the [open issues](https://github.com/jakejakearell/rails-engine/issues) for a list of proposed features (and known issues). Please open an issue ticket if you see an existing error or bug.


## Acknowledgments
  -- **Billie Thompson** - *Provided README Template* -
    [PurpleBooth](https://github.com/PurpleBooth)
