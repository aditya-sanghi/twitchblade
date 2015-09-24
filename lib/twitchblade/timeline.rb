module Twitchblade

  #job of the class is to show the timelines of different users
  #state of the class is user_id
  class Timeline
    def initialize(connection)
      @connection = connection
    end

    def get_timeline(user_name)
      @user_id = @connection.exec("select user_id from user_info where user_name = '#{user_name}'").field_values('user_id')[0].to_i
      @tweets = @connection.exec("select tweet_content from TWEETS where user_id = '#{@user_id}'").field_values('tweet_content').to_a
      @tweet_ids = @connection.exec("select tweet_id from TWEETS where user_id = '#{@user_id}'").field_values('tweet_id')
      if @tweets == []
        false
      else
        @tweets
      end
    end

    def display_timeline(user_name)

      if @tweets == nil || @user_id == 0
        puts "User does not exist or has no tweets"
      else
        puts "----------------------------------"
        puts "Displaying Timeline of #{user_name}"
        puts "----------------------------------"
        @tweet_ids.zip(@tweet_array).each do |tweet_id, tweet_content|
          puts "Tweet ID: #{tweet_id} TWEET: #{tweet_content}"
        end
      end
    end
  end
end
