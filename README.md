## docker-compose installation using repositories from The Road to GraphQL (React Express Postgres)

The docker container clone code from the book "The Road to GraphQL" https://roadtographql.com/ to start a multi-container application which is using the technologies: React, GraphQL, Apollo, Express, NodeJS and Postgres.

The code is cloned from the two repositories

* GraphQL Server Tutorial with Apollo Server and Express
https://github.com/the-road-to-graphql/fullstack-apollo-express-postgresql-boilerplate

* React with Apollo and GraphQL Tutorial
https://github.com/the-road-to-graphql/react-graphql-github-apollo

Additionally a database container with Postgres is setup.

## Requirments 

You should have docker and docker-compose installed on your machine.

## Installation 

* Clone the project from the repo 
* build your project using

 ```
 $ docker-compose build
 ```
* and/or run the following command directly inside the directory

 ```
 $ docker-compose up -d
 ```
 Your project will run under

* Web App with React at 
  http://localhost:3000/

 * API as NodeJS project with GraphQL at 
   http://localhost:8000/graphql
 

 