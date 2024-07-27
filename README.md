# CTWR NEW WEBSITE API v1 | Development Guide

## Ruby Version
ruby 3.2.4

## Rails Version
rails 7.1.3

## Docker Compose (Rails App + PostgresSQL)
* To run the app in a container, you need to have Docker and Docker Compose installed.

* Run the following command to build the image and start the container:

        docker compose up --build

* To run the app in the background, use the following command:

        docker compose up -d

* To stop the container, use the following command:

        docker compose down

* To run the app in the container, you need to create the database and run the migrations:

        docker compose run web rake db:create
        docker compose run web rake db:migrate


# CTWR NEW WEBSITE API v1 | Production Guide

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
