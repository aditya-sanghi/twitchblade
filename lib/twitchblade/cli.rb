module Twitchblade
  #job of class is to provide interface for the user
  class Cli

    def initialize(connection)
      @connection = connection
    end

    def take_input
      puts "*********"
      puts "Main Menu"
      puts "*********"
      puts "1. Signup"
      puts "2. Login"
      puts "3. View User's Timeline"
      puts "4. Exit"
      puts "enter option: "
      $stdin.gets
    end
  end
end
