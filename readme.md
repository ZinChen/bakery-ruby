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

- Open shell in project folder

- Build image

  ```sh
    docker-compose build
  ```

- Run docker container and connect to it

  ```sh
    docker-compose run shell sh
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
