module Twitchblade
  #job of class is to tweet
  class Tweet
    def initialize(connection, user_name)
      @connection = connection
      @user_name = user_name
    end

    def make_tweet
      tweet = Kernel.gets
      @user_id = @connection.exec("select user_id from user_info where user_name = '#{@user_name}'").field_values('user_id')[0].to_i
      insertion = @connection.exec_params("INSERT INTO tweets (user_id, tweet_content) VALUES ($1, $2)", [@user_id, tweet])
      insertion.cmd_tuples == 1 ? true : false
    end
  end
end

