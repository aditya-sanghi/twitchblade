module Twitchblade
  #job of class is to call the twitchblade features
  class Dispatcher
    def initialize(connection, choice)
      @connection = connection
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
            puts "1. Tweet"
            puts "2. Logout"
            puts "Enter choice: "
            logged_in_user_input = Kernel.gets
            if logged_in_user_input.to_i == 1
              puts "Enter content for tweet: "
              tweet = Tweet.new(@connection, username)
              tweet.make_tweet
              puts "You have successfully tweeted #{username}"
              puts "You have just tweeted: "
              tweet.display_tweet
              break;
            elsif logged_in_user_input.to_i == 2
              new_user.logout
              puts "You have successfully Logged Out #{username}"
              break;
            else
              puts "Invalid input for login menu!"
            end
          end
        else
          STDOUT.puts "Login Failed! Username or Password is incorrect"
        end
      elsif @choice == 3
        exit
      else
        puts "Invalid Input for Main Menu"
      end
    end
  end
end
