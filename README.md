Heroku Keepalive is a little ruby script that uses the Clockwork gem to keep your free heroku apps up and responsive. It does so by simply pinging whatever endpoints you specify at a specific interval.

## Quickstart

The following steps will get you up and running in just a couple minutes. It assumes you have Ruby 1.9.3-p125 installed via RVM, are using Bash, and have Bundler 1.2.0-pre (to get the edge Bundler, simply use `gem install bundler --pre`).

### Create your .env file

Your `.env` file needs to have two variables - `ENDPOINTS` and `INTERVAL`. A sample `.env` file is listed below.

    ENDPOINTS=http://my-errbit-app.herokuapp.com,http://my-other-app.herokuapp.com,http://www.myappwithdomain.com
    INTERVAL=60
    
### Check out the repo and create a heroku app
    
Once your `.env` file is created, we need to check out the repo and push it to a new heroku app.

1. `git clone git@github.com:scootklein/heroku-keepalive.git && cd heroku-keepalive`
2. `rvm use 1.9.3-p125 && bundle install`
2. `heroku create your-keepalive-heroku-app-name --stack cedar`
3. `git push heroku master`

### Push `.env` to heroku

    for configline in `cat .env`; do; heroku config:add $configline; done;
    
### Start the keepalive process with heroku

    heroku scale keepalive=1