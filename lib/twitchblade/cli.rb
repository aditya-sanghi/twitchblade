module Twitchblade
  #job of class is to call twitchblade functionality from
  class Cli

    def initialize(connection)
      @connection = connection
    end

    def take_input_and_call_feature
      puts "Menu"
      puts "1. Signup"
      puts "2. Exit"
      puts "enter option: "
      command = Kernel.gets
      if command.to_i == 1
        puts "enter new username: "
        username = Kernel.gets
        puts "enter new password: "
        password = Kernel.gets
        new_user = User.new(username, password, @connection)
        if new_user.signup
          STDOUT.puts "New user created"
        else
          STDOUT.puts "Signup failed! Username exists"
        end
      elsif command.to_i == 2
        exit
      else
        puts "invalid input"
      end
    end


    def infinite_input_call
      puts "Welcome to Twitchblade!"
      while (true)
        take_input_and_call_feature
      end
    end
  end
end
