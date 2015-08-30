module Twitchblade
  #job of class is to run the application
  class Application
    def initialize
      connection = PG::Connection.open(:dbname => 'testing')
      @cli = Cli.new(connection)
    end

    def run
      @cli.infinite_input_call
    end
  end
end
