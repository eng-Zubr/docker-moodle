Moodle & Docker
===============

Dockerized Moodle!

This Dockerfile installs:

 - PostgreSQL.
 - Apache.
 - Moodle (you can choose Moodle version).
 - PHPUnit environment for Moodle.

## Download

Clone the repo:

`git clone https://github.com/julenpardo/docker-moodle`

## Building the image

Just run:

`docker run -t moodle /path/to/docker-moodle`

If you want to install a specific Moodle version, specify it with `--build-arg` option, specifying a value for `moodle_version` arg. For example, the following command would create an image with 2.7 Moodle version:

`docker build --build-arg moodle_version=27 -t moodle /path/to/docker-moodle`

## Creating and accessing the container

Choose the port to map the container to. You have to specify it also as environmental variable, since the `$CFG->wwwroot` has to know it to construct the URL. For example:

`docker run -p 3456:80 -e MOODLE_PORT=3456 -d --name=moodle1 moodle`

We would have to access the site:

`localhost:3456/moodle`.
