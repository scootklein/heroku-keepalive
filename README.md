Heroku Keepalive is a little ruby script that uses the Clockwork gem to keep your free heroku apps up and responsive. It does so by simply pinging whatever endpoints you specify at a specific interval.

## Quickstart

The following steps will get you up and running in just a couple minutes. It assumes you have Ruby 1.9.3-p125 installed via RVM, are using Bash, and have Bundler 1.2.0-pre (to get the edge Bundler, simply use `gem install bundler --pre`).
    
### Check out the repo and create a heroku app

1. `git clone git@github.com:scootklein/heroku-keepalive.git && cd heroku-keepalive`
2. `rvm use 1.9.3-p125 && bundle install`
2. `heroku create your-keepalive-heroku-app-name --stack cedar`
3. `git push heroku master`

### Create your .env file and push to heroku

Foreman is the recommended way to manage your environment, and a `.env` file will store your specific environment variables. Your `.env` file needs to have two variables for heroku-keepalive to function - `ENDPOINTS` and `INTERVAL`. A sample `.env` file is listed below.

    ENDPOINTS=http://my-errbit-app.herokuapp.com,http://my-other-app.herokuapp.com,http://www.myappwithdomain.com
    INTERVAL=60
    
Once this file has been created, you can push it to heroku

    for configline in `cat .env`; do heroku config:add $configline; done
    
### Test locally (if you want)

    foreman start
    
    12:32:32 keepalive.1  | started with pid 9702
    12:32:33 keepalive.1  | I, [2012-07-06T12:32:33.386622 #9702]  INFO -- : Starting clock for 1 events: [ ping ]
    12:32:33 keepalive.1  | I, [2012-07-06T12:32:33.386750 #9702]  INFO -- : Triggering 'ping'
    12:32:33 keepalive.1  | Contacted http://my-errbit-app.herokuapp.com in 329ms
    12:32:33 keepalive.1  | Contacted http://my-other-app.herokuapp.com in 260ms
    12:32:34 keepalive.1  | FAILED to contact http://www.myappwithdomain.com -- getaddrinfo: nodename nor servname provided, or not known

### Start the keepalive process with heroku

    heroku scale keepalive=1