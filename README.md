Toopaste
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

### Using Docker

1. Git clone repo:

        git clone https://github.com/budhrg/toopaste

2. Build Image:

        docker build -t toopaste .

3. Run Toopaste as:

       docker run -p <ur_machine_port>:9292 -d toopaste rackup

       or

       docker run -p <ur_machine_port>:port_number -d toopaste rackup -p port_number

4.  Using a browser, go to `http://localhost:<ur_machine_port>`
