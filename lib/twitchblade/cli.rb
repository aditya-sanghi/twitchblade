module Twitchblade
  #job of class is to call twitchblade functionality from
  class Cli

    def initialize(connection)
      @connection = connection
    end

    def take_input_and_call_feature
      puts "Main Menu"
      puts "1. Signup"
      puts "2. Login"
      puts "3. Exit"
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
        new_user = nil
      elsif command.to_i == 2
        puts "enter username: "
        username = Kernel.gets
        puts "enter password: "
        password = Kernel.gets
        new_user = User.new(username, password, @connection)
        if new_user.login
          STDOUT.puts "Login Successful!"
          puts "Welcome #{username}"
          while (true) do
            puts "Home"
            puts "#{username} do you want to:-"
            puts "1. Logout"
            puts "Enter choice: "
            logged_in_user_input = Kernel.gets
            if logged_in_user_input.to_i == 1
              new_user.logout
              puts "You have successfully Logged Out #{username}"
              break;
            else
              puts "Invalid input!"
            end
          end

        else
          STDOUT.puts "Login Failed! Username or Password is incorrect"
        end
      elsif command.to_i == 3
        exit
      else
        puts "invalid input"
      end
    end


    def infinite_input_call
      puts "-----------------------"
      puts "Welcome to Twitchblade!"
      puts "-----------------------"
      while (true)
        take_input_and_call_feature
      end
    end
  end
end
