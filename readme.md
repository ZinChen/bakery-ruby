# Backery

Ruby console app + Docker

## Building steps

- Install docker
  - Mac, Windows: <https://www.docker.com/products/docker-desktop>
  - Linux: <https://runnable.com/docker/install-docker-on-linux>

- Install docker-compose <https://docs.docker.com/compose/install/>

- Login/Signup into docker

  ```sh
    docker login
  ```

- Build image, run docker container and connect to it

  ```sh
    docker-compose run shell bash
  ```

## Usage

Input required number of sweeties

Get result

## Run tests

  ```sh
    docker run -it hotel-ruby-app rspec
  ```

## Remove created docker containers

  ```sh
    docker container prune
  ```
