module Twitchblade
  # invokes application features
  class Dispatcher
    def initialize(connection, choice)
      @connection = connection
      @choice = choice
    end

    def invoke_feature
      if @choice == 1
        puts "enter new username: "
        username = $stdin.gets
        puts "enter new password: "
        password = $stdin.gets
        new_user = User.new(username, password, @connection)
        if new_user.signup
          STDOUT.puts "New user created"
        else
          STDOUT.puts "Signup failed! Username exists"
        end
        new_user = nil
      elsif @choice == 2
        puts "enter username: "
        username = $stdin.gets
        puts "enter password: "
        password = $stdin.gets
        logged_in_user = User.new(username, password, @connection)
        if logged_in_user.login
          STDOUT.puts "Login Successful!"
          puts "Welcome #{username}"
          while (true) do
            puts "-----------"
            puts "Home"
            puts "-----------"
            puts "#{username}"
            puts "-----------"
            puts "do you want to:-"
            puts "1. Tweet"
            puts "2. View your Timeline"
            puts "3. View someone else's Timeline"
            puts "4. Follow someone"
            puts "5. View list of who all you are following: "
            puts "6. View list of your followers: "
            puts "7. View you Wall"
            puts "8. Retweet"
            puts "9. Logout"
            puts "Enter choice: "
            logged_in_user_input = $stdin.gets
            if logged_in_user_input.to_i == 1
              puts "Enter content for tweet: "
              tweet = Tweet.new(@connection, username)
              tweet.make_tweet
              puts "You have successfully tweeted #{username}"
              puts "You have just tweeted: "
              tweet.display_tweet
            elsif logged_in_user_input.to_i == 2
              timeline = Timeline.new(@connection, username)
              timeline.get_timeline
              timeline.display_timeline(username)
            elsif logged_in_user_input.to_i == 3
              puts "Enter user name whose timeline you wish to view!"
              username_to_view_timeline = $stdin.gets
              timeline = Timeline.new(@connection, username_to_view_timeline)
              timeline.get_timeline
              timeline.display_timeline(username_to_view_timeline)
            elsif logged_in_user_input.to_i == 4
              puts "Enter username of person who you want to follow"
              username_to_follow = $stdin.gets
              if logged_in_user.follow(username_to_follow)
                puts "You are now following #{username_to_follow}"
              else
                puts "The user does not exist or you are already following the specified user"
              end
            elsif logged_in_user_input.to_i == 5
              puts "You are following:-"
              list_of_users_being_followed = logged_in_user.list_users_being_followed
              puts list_of_users_being_followed
            elsif logged_in_user_input.to_i == 6
              puts "You are being followed by:-"
              list_of_followers = logged_in_user.list_followers
              puts list_of_followers
            elsif logged_in_user_input.to_i == 7
              puts "THE WALL:-"
              Wall.new(@connection, username).display_wall
            elsif logged_in_user_input.to_i == 8
              tweet = Tweet.new(@connection, username)
              puts "Enter Tweet-ID of the Tweet that you want to RETWEET"
              if tweet.retweet
                puts "You have successfully REtweeted #{username}"
                puts "You have just retweeted: "
                tweet.display_retweet
              else
                puts "That is not a Retweetable Tweet-ID"
              end
            elsif logged_in_user_input.to_i == 9
              logged_in_user.logout
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
        puts "Enter user name whose timeline you wish to view!"
        target_username = $stdin.gets
        timeline = Timeline.new(@connection, target_username)
        timeline.get_timeline
        timeline.display_timeline(target_username)
      elsif @choice == 4
        @connection.close
        exit
      else
        puts "Invalid Input for Main Menu"
      end
    end
  end
end
