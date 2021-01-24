# WordPress Local Development Image
I find the [official WordPress image](https://hub.docker.com/_/wordpress) very big and clunky for local development. All I need is the PHP's [built-in server](https://www.php.net/manual/en/features.commandline.webserver.php) when developing locally. This image does just that.

This image built by:
- Extending from Ubuntu 20.04 image
- Installing PHP 7.4 and development tools such [WP-CLI](https://wp-cli.org)
- Mounting `wp-config.php` and `wp-content/` into the WordPress in container

## Installation
You can start the container via:
```sh
PROJECT_NAME=your_project;

docker run --rm -it \
    -p 8080:8080 \
    --name $PROJECT_NAME \
    --volume $(pwd)/wp-config.php:/root/project/wp-config.php \
    --volume $(pwd)/wp-content:/root/project/wp-content:cached \
    raicem:wordpress
```

After the container is started, you can initialize the server:
```sh
docker exec -it $PROJECT_NAME php -S 0.0.0.0:8080
```

Your WordPress installation will be available at [http://0.0.0.0:8080](http://0.0.0.0:8080).

## Database
You'll need a database to go with the WordPress installation. You can choose to use the official [MariaDB](http://hub.docker.com/_/mariadb) or [MySQL](http://hub.docker.com/_/mysql) images. For example this is how I create a MariaDB instance running locally:

```sh
docker run --rm \ 
    --name $PROJECT_NAME \ 
    -e MYSQL_ROOT_PASSWORD=root \ 
    -p 3306:3306 \ 
    mariadb:10.5.8-focal
```

Then I reference the database host in my project's `wp-config.php` file.

## WP-CLI usage
You can access WP-CLI via `wp` command on the container
```sh
docker exec -it $PROJECT_NAME wp
```

## First Run

After you get the server up and running, you can follow installation instructions on the website. 

Alternatively, you can install WordPress via `wp install` command in one go.
```sh
docker exec -it $PROJECT_NAME wp core install --url=0.0.0.0:8080 --title='Your Project' --admin_user=admin --admin_password=password --admin_email=info@example.com
```