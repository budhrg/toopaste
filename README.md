Toopaste [![Codeship Status for budhrg/toopaste](https://www.codeship.io/projects/cc63cd10-08ef-0133-7b27-6a857506946a/status?branch=master)](https://codeship.com/projects/90428)
========

A simple (and tiny) Pastie clone written in Sinatra and ActiveRecord.
Clone from repo https://github.com/zapnap/toopaste.

## Getting Started

1. Git clone repo:

        git clone https://github.com/budhrg/toopaste

2. Bundle Install:

        bundle install

3. Start the web server as:

        rackup [-p port_number]

4. Using a browser, go to `http://localhost:9292(or port_number)`

### Using Docker linking with mysql container

1. Git clone repo:

        git clone https://github.com/budhrg/toopaste

2. Pull mysql image from repo:

        docker pull mysql:5.5

3. Build image of Toopaste:

        docker build -t toopaste .

4. Run Toopaste as:

  4.1 Run mysql container:

        docker run --name <mysql_container_name> -e MYSQL_ROOT_PASSWORD=<password> -d mysql:5.5

    4.2 Run toopaste:

        docker run --name <toopaste_container_name> --link <mysql_container_name>:<alias> -e "DB_PREFIX=<alias>" -p <ur_machine_port>:9292 -d toopaste sh -c "rake db:create && rake db:migrate rackup -o 0.0.0.0"

        or

        docker run --name <toopaste_container_name> --link <mysql_container_name>:<alias> -e "DB_PREFIX=<alias>" -p <ur_machine_port>:port_number -d toopaste sh -c "rake db:create && rake db:migrate rackup -o 0.0.0.0 -p port_number"

  Note: Give alias in capital

5. Using a browser, go to `http://localhost:<ur_machine_port>`

### Using [Docker Compose](https://docs.docker.com/compose/install)

1. Git clone repo:

        git clone https://github.com/budhrg/toopaste

2. Pull mysql image from repo:

        docker pull mysql:5.5

3. docker-compose up -d

4. Using a browser, go to `http://localhost:3000`
