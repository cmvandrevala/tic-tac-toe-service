# Tic-Tac-Toe Service

[![Build Status](https://travis-ci.org/cmvandrevala/tic-tac-toe-service.svg?branch=master)](https://travis-ci.org/cmvandrevala/tic-tac-toe-service)

## Background

This is a toy application that I will use to learn about SOA during my apprenticeship at 8th Light. The Rails app will serve different types of data to various clients in a JSON format. In order to practice using SQL, I am going to replace many of the ActiveRecord functions with raw SQL.

## Testing

This project uses rspec as its test suite. You can run the test suite using the command:

```
bundle exec rspec spec
```

## Running the App

You can run the app using the built-in rails server:

```
rails s
```

This app is deployed on heroku, and can be found at ```https://dry-wave-85958.herokuapp.com/```. There are two API endpoints:

1. Return a list of the endpoints hit ```/api/endpoints_hit?client_name=<client_name>```

2. Return a move from a first-available-spot computer player ```/api/computer_move?client_name=<client_name>&board=<current_moves_in_json_format>```

An example of the second point above is given below:

```https://dry-wave-85958.herokuapp.com/api/computer_move?board={"moves": [{"player_one": 4}]}&client_name=Bob```
