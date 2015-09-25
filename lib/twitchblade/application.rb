require 'pg'
require 'figaro'

module Twitchblade
  #job of class is to run the application
  class Application
    def initialize
      @connection = PG::Connection.open(dbname: ENV["dbname"], user: ENV["db_user"], password: ENV["password"],
                                        host: ENV["db_host_ip"], port: ENV["db_host_port"])
      @cli = Cli.new(@connection)
    end

    def run
      puts "-----------------------"
      puts "Welcome to Twitchblade!"
      puts "-----------------------"
      loop do
        input = @cli.take_input
        Dispatcher.new(@connection, input.to_i).invoke_feature
      end
    end
  end
end

