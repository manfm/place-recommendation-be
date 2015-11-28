#!/bin/bash --login

rvm requirements
rvm install ruby
rvm use ruby --default
rvm rubygems current

gem install rails
