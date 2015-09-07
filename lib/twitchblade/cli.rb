module Twitchblade
  #job of class is to provide interface for the user
  class Cli

    def initialize(connection)
      @connection = connection
    end

    def take_input
      puts "Main Menu"
      puts "1. Signup"
      puts "2. Login"
      puts "3. Exit"
      puts "enter option: "
      Kernel.gets
    end
  end
end
