module Twitchblade
  #job of class is to tweet
  class Tweet
    def initialize(connection, user_name)
      @connection = connection
      @user_name = user_name
      @user_id = @connection.exec("select user_id from user_info where user_name = '#{@user_name}'").field_values('user_id')[0].to_i
    end

    def input
      Kernel.gets
    end

    def make_tweet
      inserted_tweet = @connection.exec_params("INSERT INTO tweets (user_id, tweet_content) VALUES ($1, $2)", [@user_id, input])
      current_tweet_id = @connection.exec("select tweet_id from tweets where user_id = '#{@user_id.to_i}' order by lastmodified desc limit 1").field_values('tweet_id')[0]
      inserted_tweet.cmd_tuples == 1 ? current_tweet_id : false
    end

    def display_tweet
      tweet = @connection.exec("select tweet_content from tweets where user_id = '#{@user_id.to_i}' order by lastmodified desc limit 1").field_values('tweet_content')[0].to_s
      puts tweet
    end

    def retweet
      tweet_id_to_be_retweeted = input
      find_tweet = @connection.exec("select tweet_id from tweets where tweet_id = #{tweet_id_to_be_retweeted}")
      if find_tweet.ntuples == 0
        false
      else
        retweet_content = @connection.exec("SELECT TWEET_CONTENT from tweets where tweet_id = #{tweet_id_to_be_retweeted}").field_values('tweet_content')[0]
        @new_tweet_id = @connection.exec_params("INSERT into tweets (user_id, tweet_content) VALUES ($1, $2) returning TWEET_ID", [@user_id, retweet_content]).field_values('TWEET_ID')[0]
        origin_tweet_id = @connection.exec("select tweet_id from RETWEETS where tweet_id = #{tweet_id_to_be_retweeted}").field_values('TWEET_ID')[0]
        if origin_tweet_id == nil
          origin_tweet_id = tweet_id_to_be_retweeted
        end
        @connection.exec_params("INSERT into retweets (tweet_id, tweet_id_retweeted_from, origin_tweet_id ) VALUES ($1, $2, $3)", [@new_tweet_id, tweet_id_to_be_retweeted, origin_tweet_id])
        origin_tweet_id
      end
    end

    def display_retweet
      tweet = @connection.exec("select tweet_content from tweets where tweet_ID = #{@new_tweet_id}").field_values('tweet_content')[0].to_s
      puts tweet
    end
  end
end
