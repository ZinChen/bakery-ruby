# Bakery

Ruby console app + Docker

Algorithm solves task of breakdown needed product quantity into packs.

## Setup

- Install docker
  - Mac, Windows: <https://www.docker.com/products/docker-desktop>
  - Linux: <https://runnable.com/docker/install-docker-on-linux>

- Install docker-compose <https://docs.docker.com/compose/install/>

- Login/Signup into docker

  ```sh
    docker login
  ```

- Open shell with the project folder

- Build image

  ```sh
    docker-compose build
  ```

## Usage

- Run docker container, script will run immediately

  ```sh
    docker-compose run shell
  ```

- Input required quantity of a product and it's code

  ```sh
    13 CF
  ```

- If the product code is correct and quantity can be split in packages you will see correct result

- If the input is incorrect in some way you will see an error message

## Run tests

  ```sh
    docker-compose run shell rspec
  ```

## Run rubocop linter

  ```sh
    docker-compose run shell rubocop
  ```

## Open shell with runnable environment

  ```sh
    docker-compose run shell sh
  ```

## Cleanup docker containers

  ```sh
    docker container prune
  ```
