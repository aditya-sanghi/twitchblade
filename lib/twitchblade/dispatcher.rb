module Twitchblade
  #job of class is to call the twitchblade features
  class Dispatcher
    def initialize(connection, choice)
      connection = connection
      @choice = choice
    end

    def invoke_feature
      if @choice == 1
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
      elsif @choice == 2
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
        end

      end
    end
  end
end
