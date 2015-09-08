module Twitchblade
  #job of class is to tweet
  class Tweet
    def initialize(connection, user_name)
      @connection = connection
      @user_name = user_name
    end

    def input
      Kernel.gets
    end

    def make_tweet
      @user_id = @connection.exec("select user_id from user_info where user_name = '#{@user_name}'").field_values('user_id')[0].to_i
      insertion = @connection.exec_params("INSERT INTO tweets (user_id, tweet_content) VALUES ($1, $2)", [@user_id, input])
      insertion.cmd_tuples == 1 ? true : false
    end

    def display_tweet
      tweet = @connection.exec("select tweet_content from tweets where user_id = '#{@user_id.to_i}' order by lastmodified desc limit 1").field_values('tweet_content')[0].to_s
      puts tweet
    end
  end
end

