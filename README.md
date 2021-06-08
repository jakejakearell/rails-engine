# Rails Engine

An API designed to power an Ecommerce web application

## Authors

* **Jacob Arellano** -- [GitHub](https://github.com/jakejakearell) |
  [LinkedIn](https://www.linkedin.com/in/jacob-arellano-ab2890207/)

## Summary

  - [Getting Started](#getting-started)
  - [Database Normalization](#database-normalization)
  - [Running the test suite](#running-the-test-suite)
  - [Endpoints](#endpoints)
  - [Built With](#built-with)
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
   git clone https://github.com/jakejakearell/rails-engine
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

[Database Design](insertlinkhere)

## Running the test suite
```sh
$ rails bundle exec rspec
```
The tests are all built using the [RSpec](https://rspec.info/) and [Capybara](https://github.com/teamcapybara/capybara) test suites.

## Endpoints

### Merchants: retrieves all merchants
Returns all merchants. Defaults to a max of 20 merchants per page. Can take
additional params of page and per_page.

Request: `GET http://localhost:3000/api/v1/merchants`  

#### Example:
Request: `GET http://localhost:3000/api/v1/merchants`  
Response body:

```
{
  "data": [
    {
      "id": "1",
        "type": "merchant",
        "attributes": {
          "name": "Mike's Awesome Store",
        }
    },
    {
      "id": "2",
      "type": "merchant",
      "attributes": {
        "name": "Store of Fate",
      }
    },
    {
      "id": "3",
      "type": "merchant",
      "attributes": {
        "name": "This is the limit of my creativity",
      }
    }
  ]
}
```

### Merchant: retrieves one merchant
Returns one merchant if given merchant id

Request: `GET http://localhost:3000/api/v1/merchants/:id`  

#### Example:
Request: `GET http://localhost:3000/api/v1/merchant/:id`  
Response body:

```
{
    "data": {
        "id": "1",
        "type": "merchant",
        "attributes": {
            "name": "Schroeder-Jerde"
        }
    }
}
```

### Merchant Items: retrieves one merchant
Returns a merchant's items if given a merchant id

Request: `GET http://localhost:3000/api/v1/merchants/:id/items`  

#### Example:
Request: `GET http://localhost:3000/api/v1/merchants/:id/items`  
Response body:

```
{
    "data": [
        {
            "id": "16",
            "type": "item",
            "attributes": {
                "name": "Item Adipisci Sint",
                "description": "Iure cumque laborum hic autem quidem voluptas. Quis eum adipisci neque magnam. Commodi molestiae exercitationem.",
                "unit_price": 229.51,
                "merchant_id": 2
            }
        },
        {
            "id": "17",
            "type": "item",
            "attributes": {
                "name": "Item Laudantium Ex",
                "description": "In dolor architecto doloribus omnis fuga. Dolor minima voluptatem libero voluptatem cum magni ipsam. Et est minus quis doloremque. Praesentium voluptatem dicta eos.",
                "unit_price": 607.13,
                "merchant_id": 2
            }
        },
        ect....
    ]
}
```

### Items: retrieves one item
Returns a item if given a item id

Request: `GET http://localhost:3000/api/v1/items/:id/`  

#### Example:
Request: `GET http://localhost:3000/api/v1/items/:id/`  
Response body:

```
{
  "data": {
    "id": "16",
    "type": "item",
    "attributes": {
      "name": "Widget",
      "description": "High quality widget",
      "unit_price": 100.99,
      "merchant_id": 14
    }
  }
}
```

### Item Update: Updates one item
Updates an item. Must include name, description, unit price and merchant_id in request body

Request: `PUT http://localhost:3000/api/v1/items/:id`  

#### Example:
Request: `PUT http://localhost:3000/api/v1/items/16`  
Request body:
```
{
  "name": "value1",
  "description": "value2",
  "unit_price": 100.99,
  "merchant_id": 14
}
```
Response body:
```
{
  "data": {
    "id": "16",
    "type": "item",
    "attributes": {
      "name": "value1",
      "description": "value2",
      "unit_price": 100.99,
      "merchant_id": 14
    }
  }
}
```
### Item Create: Creates an item
Creates an item. Must include name, description, unit price and merchant_id in request body

Request: `POST http://localhost:3000/api/v1/items/`  

#### Example:
Request: `POST http://localhost:3000/api/v1/items/`  
Request body:
```
{
  "name": "value3",
  "description": "value4",
  "unit_price": 100.99,
  "merchant_id": 14
}
```
Response body:
```
{
  "data": {
    "id": "17",
    "type": "item",
    "attributes": {
      "name": "value3",
      "description": "value4",
      "unit_price": 100.99,
      "merchant_id": 14
    }
  }
}
```
### Items: retrieves one item
Returns a item if given a item id

Request: `GET http://localhost:3000/api/v1/items/:id/`  

#### Example:
Request: `GET http://localhost:3000/api/v1/items/:id/`  
Response body:

```
{
  "data": {
    "id": "16",
    "type": "item",
    "attributes": {
      "name": "Widget",
      "description": "High quality widget",
      "unit_price": 100.99,
      "merchant_id": 14
    }
  }
}
```

## Built With

  * [Ruby on Rails](https://rubyonrails.org)
  * [HTML](https://html.com)


## Acknowledgments
  -- **Billie Thompson** - *Provided README Template* -
    [PurpleBooth](https://github.com/PurpleBooth)
