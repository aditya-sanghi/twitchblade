#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), "..", "lib")))

require 'pg'
require 'figaro'
begin
  Figaro.application = Figaro::Application.new(environment: "staging", path: "../config/application.yml")
  Figaro.load

  require 'twitchblade'
  Twitchblade::Application.new.run

#rescue PG::ConnectionBad
 # puts "Postgres Database Connection Unsuccesful!"
 # puts "Kindly check the database configuration"
end