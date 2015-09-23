#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), "..", "lib")))

require 'twitchblade'
begin
  Twitchblade::Application.new.run

rescue PG::ConnectionBad
  puts "Postgres Database Connection Unsuccesful!"
  puts "Kindly check the database configuration"
end