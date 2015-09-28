#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), "..", "lib")))

require 'pg'
require 'figaro'
begin
  if ARGV[0] == nil
    ARGV[0] = "staging"
  end
  Figaro.application = Figaro::Application.new(environment: ARGV[0], path: "../config/application.yml")
  Figaro.load

  require 'twitchblade'
  Twitchblade::Application.new.run

rescue PG::ConnectionBad
  puts "Postgres Database Connection Unsuccessful!"
  puts "Kindly check the database configuration"
end