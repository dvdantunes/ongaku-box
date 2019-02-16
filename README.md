# Ongaku Box

### Code status
[![Build Status](https://travis-ci.com/dvdantunes/promptworks-demo-tape.svg?token=oXc14pfxPystduN1ouCp&branch=development)](https://travis-ci.com/dvdantunes/promptworks-demo-tape)
[![Ruby version](https://img.shields.io/badge/Ruby-v2.5.3-blue.svg)](https://github.com/ruby/ruby/releases/tag/v2_5_3)
[![Rails version](https://img.shields.io/badge/Rails-v5.2.2-blue.svg)](https://github.com/rails/rails/releases/tag/v5.2.2)
[![React](https://img.shields.io/badge/React-v16.8.1-blue.svg)](https://github.com/facebook/react/releases/tag/v16.8.1)
[![Commitizen friendly](https://img.shields.io/badge/commitizen-friendly-brightgreen.svg)](http://commitizen.github.io/cz-cli/)


### Overview

`Ongaku Box` is an amazing simple app where you can search for your favourites `Bands` and `Artists` and recieve theirs `Top tracks` through a SMS sent to your phone.


### Quick Start

The app was developed as a [Single-page Application](https://medium.com/@NeotericEU/single-page-application-vs-multiple-page-application-2591588efe58). It consists of a single microservice containerized with **Docker**, using the official [Ruby 2.5 Alpine](https://hub.docker.com/_/ruby/) image. It also provides an **API** entrypoint to receive requests from any client.

It uses **Rails** on the back-end and **React** on the front-end, and uses **react_on_rails** Ruby gem to handle Rails and React task and communication. It is build with `docker-compose` tasks and custom `Makefile` rules.

The app also uses the services provided by **Twilio** and **Spotify**, to send SMS messages and request music metadata, respectively. It depends on **twilio-ruby** and **rspotify** Ruby gems, which allow to authenticate and send requests to Twilio and Spotify, respectively.

This documentation will help you to build and deploy them to **Amazon ECS**, which will run a cluster with an **EC2** instance specially optimized to run Docker containers.


### Demo

You can see **Ongaku Box** in action through your browser on its [demo web UI](http://ec2-34-201-209-193.compute-1.amazonaws.com:3000/)

Also, you can reach **Ongaku Box API** running on its [demo API entrypoint](http://ec2-34-201-209-193.compute-1.amazonaws.com:3000/api/v1/). You need to request it through `POST` method. For example:

    $ curl -v -H 'Content-Type: application/json' -d '{"artist_name":"Muse","phone_number":"+56952496480"}' -X POST http://ec2-34-201-209-193.compute-1.amazonaws.com:3000/api/v1/service/send_artist_top_track


### Prerequisites and dependencies

You will need a **AWS account** to fully deploy this project. It is recommended to use a **Free Tier** account.

To follow CI best practices, you can activate your repository on [travis.org](https://travis.org) and use the `travis.yml` provided file.

Also, you will need to install the following tools and technologies:

- gcc >= 5.4.0
- yarn == 1.7.0
- Docker >= 18.09.1
- docker-compose >= 1.22.0
- aws-cli >= 1.16.96
- ecs-cli >= 1.12.1
- foreman >= 0.85.0
- Ruby == 2.5.3
- Rails == 5.2.2
- node == 9.1.1
- React >= 16.8.1
- @rails/webpacker == 3.5
- react_on_rails (gem) == 11.2.2
- bootstrap (gem) == 4.2.1
- sass-rails (gem) == 5.0
- twilio-ruby (gem) == 5.19.0
- rspotify (gem) == 2.4


## Local development environment

- `make dev-install` to define and install dependencies for local development environment
- `make dev-run` to install dependencies, start up and run the app, on development mode
- `make dev-run-fast` to quickly start up and run the app, on development mode (assumes it is already installed)
- `make dev-shell` to enter bash console on the already started up app, on development mode


## Local production environment

- `make install` to define and install dependencies for local production environment
- `make run` to install dependencies, start up and run the app, on production mode
- `make run-fast` to quickly start up and run the app, on production mode (assumes it is already installed)
- `make shell` to enter bash console on the already started up app, on production mode



## Running tests

- `make test` to run Rspec tests on Rails app



## Production building and deployment

First of all, you need to activate **Amazon ECR** and **Amazon ECS services**.

Please adjust your `AWS credentials` and configuration on `bin/aws-config.sh`. You need to enter a `VPC` and its `Subnets`, `Security Group` and `Instance Role`.


#### AWS Security group

For the `Security group`, you need to expose traffic to the following ports:

- 3000 (to allow **Ongaku Box** requests)
- 80 (to allow default requests and routing traffic within Docker containers)


#### AWS Instance Role

For the `Instance Role`, you need to attach the following AWS policies:

- AmazonElastiCacheFullAccess
- AmazonEC2ContainerServiceFullAccess
- AmazonECSTaskExecutionRolePolicy
- AmazonEC2ContainerServiceforEC2Role


#### Setup Amazon ECS cluster

Then you need to setup the **Amazon ECS Cluster**. To do that, please adjust your credentials and configuration on `bin/aws-config.sh` file and then run `make setup-production`. You need to do this only once per cluster.


#### Build and deploy

Finally, run `make build` to build the `Docker image` for the app microservice and send them to its repository on `Amazon ECR`. Then, run `make deploy` to scale up the instance on the `Cluster`, create a `Service` and run a `Task Definition`, which runs and exposes the app microservice. You can find the deployment configuration and policies on `docker-compose-production.yml` and `ecs-params.yml` files.

To view the running app public IP and Task list, you can use `make status` rule.


#### List of building and deployment utilities

Below is the full list of the utilities used to build and deploy the project:

- `make setup-production` to setup a custom `Cluster` on `Amazon ECS` to be able to deploy the app. You need to adjust `bin/aws-config.sh` file
- `make build` to build `Docker` image and push it to `Amazon ECR` repositories
- `make deploy` to deploy a `Service` with defined `Task Definitions` to an `EC2 instance` with Docker container support, through `Amazon ECS`
- `make status` to check `Docker` images history on `Amazon ECR` and `Task Definitions` status (RUNNING, STOPPED, DRAINING, etc) on `Amazon ECS`
- `make scale-down` to scale-down the current running `Service` and its `Task Definitions`
- `make scale-up` to scale-up the last created `Service` and its `Task Definitions`
- `make remove-production` to scale-down the current running `Services` and its `Task Definitions`, and permanently delete the `Amazon ECS cluster`



## Other utilities

- `make commit` better commits with [Commitizen](http://commitizen.github.io/cz-cli/), using AngularJS's commit message convention (cz-conventional-changelog)



