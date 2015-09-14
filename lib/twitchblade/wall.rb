module Twitchblade
  class Wall
    def initialize(connection)
      @connection = connection
    end

    def get_wall_tweets(user_name)
      @user_id = @connection.exec("select user_id from user_info where user_name = '#{user_name}'").field_values('user_id')[0].to_i
      @wall = @connection.exec("select tweet_content from TWEETS where user_id = '#{@user_id}' OR user_id in (select following_user_id from FOLLOWERS where user_id = '#{@user_id}')").field_values('tweet_content').to_a
      @wall
    end
  end
end