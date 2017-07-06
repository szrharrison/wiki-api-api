# Wiki API (...API)

This README documents the necessary steps for getting the
backend API up and running.

* Ruby version: `ruby-2.4.1`
  * install with: `rvm install 2.4.1`

* System dependencies: MongoDB
  * to install MongoDB, follow the instructions [here](https://docs.mongodb.com/manual/administration/install-community/)

* Configuration: make sure to run:
  * `bundle install` after setting up Ruby and MongoDB
  * `bundle exec figaro install`
    * in your newly created `config/application.yml` file, generate 2 secrets(`rake secret`) and add these keys:
```yml
JWT_SECRET:
JWT_ALGORITHM: 'HS256' #or one of the other options provided by JWT
SECRET_KEY_BASE:
```
* Database seeding:
  * For some sample data from the [pokémon api](https://pokeapi.co/), run `rake db:seed`
  * You will be able to see the seeded API when logged in with username: `admin` and password: `asdf`

* When ready, just run `rails s` and visit http://localhost:3000 to login or http://localhost:3000/pokemon-api to start looking at the seeded data.
