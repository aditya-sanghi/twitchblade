require 'pg'

module Twitchblade
  #job of class is to run the application
  class Application
    def initialize
      @connection = PG::Connection.open(:dbname => 'testing')
      @cli = Cli.new(@connection)
    end

    def run
      puts "-----------------------"
      puts "Welcome to Twitchblade!"
      puts "-----------------------"
      while (true)
        input = @cli.take_input
        Dispatcher.new(@connection, input.to_i).invoke_feature
      end
    end
  end
end

