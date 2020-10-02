#! /bin/sh
heroku login --interactive
heroku keys:add

heroku create
git push heroku master
heroku run rails db:migrate
