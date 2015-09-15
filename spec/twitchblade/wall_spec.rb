require 'spec_helper'

module Twitchblade

  describe 'Wall' do
    before(:all) do
      @connection = PG::Connection.open(:dbname => 'testing')
    end

    before(:each) do
      @connection.exec("ALTER SEQUENCE tweets_tweet_id_seq RESTART WITH 1")
      #@connection.exec("UPDATE t SET idcolumn=nextval('seq')")
      @user_1 = User.new("aditya.sng931", "123", @connection)
      @user_1.signup
      @user_2 = User.new("saim931", "123", @connection)
      @user_2.signup
      @user_1.login
      @user_1.follow("saim931")
      @wall = Wall.new(@connection, "aditya.sng931")
      tweet_for_user_1 = Tweet.new(@connection, "aditya.sng931")
      tweet_for_user_2 = Tweet.new(@connection, "saim931")
      allow(Kernel).to receive(:gets).and_return("aditya-tweet-1")
      tweet_for_user_1.make_tweet
      allow(Kernel).to receive(:gets).and_return("saim-tweet-1")
      tweet_for_user_2.make_tweet
      allow(Kernel).to receive(:gets).and_return("aditya-tweet-2")
      tweet_for_user_1.make_tweet
    end

    after(:each) do
      @connection.exec("delete from user_info")
      @connection.exec("delete from tweets")
      @connection.exec("delete from followers")
    end

    it 'should return all the tweets of the user as well of users he is following in chronological order!' do
      wall = @wall.get_wall_tweets
      expect(wall).to eq (["aditya-tweet-1", "saim-tweet-1", "aditya-tweet-2"])
    end

    it 'should return all the tweet IDs of the tweets of the user as well of users he is following in chronological order!' do
      wall_tweet_ids = @wall.get_wall_tweet_ids
      expect(wall_tweet_ids).to eq (["1", "2", "3"])
    end

    it 'should return all the tweet IDs of the tweets of the user as well of users he is following in chronological order!' do
      wall_tweet_ids = @wall.get_wall_tweet_ids
      expect(wall_tweet_ids).to eq (["1", "2", "3"])
    end

    it 'should return all the user names of the tweets of a users wall!' do
      user_names = @wall.get_user_names
      expect(user_names).to eq (["aditya.sng931", "saim931", "aditya.sng931"])
    end
  end
end