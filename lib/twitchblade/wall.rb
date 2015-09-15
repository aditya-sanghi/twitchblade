module Twitchblade
  class Wall
    def initialize(connection, user_name)
      @connection = connection
      @user_name = user_name
      @user_id = @connection.exec("select user_id from user_info where user_name = '#{@user_name}'").field_values('user_id')[0].to_i
    end

    def get_wall_tweets
      @wall_tweet_content = @connection.exec("select tweet_content from TWEETS where user_id = '#{@user_id}' OR user_id in (select following_user_id from FOLLOWERS where user_id = '#{@user_id}')").field_values('tweet_content').to_a
      @wall_tweet_content
    end

    def get_wall_tweet_ids
      @wall_tweet_ids = @connection.exec("select tweet_id from TWEETS where user_id = '#{@user_id}' OR user_id in (select following_user_id from FOLLOWERS where user_id = '#{@user_id}')").field_values('tweet_id')
      @wall_tweet_ids
    end

    def get_user_names
      wall_tweet_user_ids = @connection.exec("select user_id from TWEETS where tweet_id in(SELECT tweet_id from TWEETS where user_id = '#{@user_id}' OR user_id in (select following_user_id from FOLLOWERS where user_id = '#{@user_id}'))").field_values('user_id')
      @wall_user_names = Array.new
      wall_tweet_user_ids.each do |user_id|
        @wall_user_names.push(@connection.exec("select user_name from user_info where user_id = #{user_id}").field_values('user_name')[0])
      end
      @wall_user_names
    end

    def display_wall
      get_wall_tweet_ids
      get_wall_tweets
      get_user_names
      if @wall_tweet_ids == []
        puts "There are no tweets on your wall"
      else
        @wall_tweet_ids.each_with_index do |tweet_id, index|
          if @wall_user_names[index] == @user_name
            puts "You Tweeted:- #{@wall_tweet_content[index]}  Tweet-ID: #{tweet_id}"
          else
            puts "#{@wall_user_names[index]} Tweeted:- #{@wall_tweet_content[index]}  Tweet-ID: #{tweet_id}"
          end
        end
      end
    end
  end
end