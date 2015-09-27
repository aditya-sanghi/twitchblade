#TwitchBlade

##Description

Twitchblade is a Command Line Interface application that is based on twitter. It has features like signup for a new
user, signing in, tweeting and retweeting which are stored on a database.

##Technology Stack

Twitchblade uses ruby as the primary programing language. The backend is Postgres database to store
user info, user tweets etc.

##Setup

1. clone the project from git@github.com:aditya-sanghi/twitchblade.git
2. cd into the project.
3. Build

##Install Bundler

1. gem install bundler
2. bundle install
3. To run the specs : bundle exec rake

##Run Specs

1. bundle exec rspec [SPECFILE_PATH:LINE]  -to run specific specs
OR
2. bundle exec rake -to run all specs at once

## To Run the App
Go to the app directory in terminal and type: ruby bin/twitchblade.rb