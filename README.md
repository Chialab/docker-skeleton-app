# Docker skeleton app
Skeleton app for a full-featured Docker dev environment. Mostly suitable for Web development.

## Features
This skeleton app is shipped with all these features out-of-the-box.

- Web servers:
  - Apache
  - Nginx
- PHP versions (as a module in Apache, via FastCGI in Nginx):
  - 5.4
  - 5.5
  - 5.6
- Databases:
  - MySQL 5.6
  - MySQL 5.5
  - PostgreSQL 9.4
  - PostgreSQL 9.5 (currently in beta)
- Cache engines:
  - Memcached
  - Redis
- Other:
  - Elasticsearch
  - Logstash
  - Kibana

## Getting started
1. Ensure you have a fairly recent version of Docker installed and that the Docker daemon is up and running.
2. Clone this repository:

    ```bash
    git clone git@github.com:Chialab/docker-skeleton-app.git my-docker-dir
    cd my-docker-dir/
    ```

3. Pull required Docker images and create data containers — required for data persistence in Elasticsearch, MySQL and PostgreSQL.
    You can easily perform this task running this command in the project root (it **will** take a while to pull all images):

    ```bash
    make setup
    ```

4. To start the whole stack, use Docker Compose:

    ```bash
    docker-compose up -d
    ```

## Configuring Apache and Nginx
All web resources should be placed within the `www` directory, that is mounted as a volume in all Apache, Nginx and PHP FPM containers.

Configuration for Apache and Nginx should be placed in the `conf/apache` and `conf/nginx` directories respectively. Here you can configure virtual hosts, server blocks, and other stuff. Please, check the provided `001-default.conf` files (that map to `www/html` folder) for configuration examples for both webservers.

Don't forget to update `docker-compose.yml` file with the actual IP of your Docker machine (by default, is set to `192.168.99.100`) and of your remote client (by default, `192.168.99.1`). You can find such values in the `env` service, in the very first rows of the file. Unfortunately, Nginx doesn't provide a clean way to use environment variables in configuration files, so you'll have to edit those values manually in `conf/nginx` configuration files, too.

## Using
All these web servers are mapped to a different port:

- Apache/PHP 5.6 is mapped to port `8056`.
- Apache/PHP 5.5 is mapped to port `8055`.
- Apache/PHP 5.4 is mapped to port `8054`.
- Nginx is mapped to port `8080`. You can choose which PHP FPM version to use via configuration in the server block.

## Upgrading
Sometimes, Docker images are updated. You can keep your environment up-to-date by running:

```bash
docker-compose pull     # Update Docker images
docker-compose stop     # Stop running containers
docker-compose up -d    # Recreate updated containers, and restart full stack
```

## Uninstalling
If you want to remove containers and clean up your Docker environment, run:

```bash
docker-compose stop     # Stop running containers
docker-compose rm -fv   # Remove stopped containers
```

In case you also want to remove your data containers, run `make clean`. **WARNING**: doing so will result in all your databases and data going lost!!!