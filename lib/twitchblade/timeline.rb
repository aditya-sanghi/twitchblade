module Twitchblade
  class Timeline
    def initialize(connection)
      @connection = connection
    end

    def get_timeline(user_name)
      @user_id = @connection.exec("select user_id from user_info where user_name = '#{user_name}'").field_values('user_id')[0].to_i
      if @user_id == 0
        false
      else
        tweet_array = @connection.exec("select tweet_content from TWEETS where user_id = '#{@user_id}'").field_values('tweet_content').to_a
        tweet_array
      end
    end
  end
end