require 'spec_helper'
module Twitchblade

  describe 'Tweet' do

    before(:all) do
      @connection = PG::Connection.open(:dbname => 'testing')
    end

    before(:each) do
      @connection.exec("ALTER SEQUENCE tweets_tweet_id_seq RESTART WITH 1")
    end

    after(:each) do
      @connection.exec("delete from tweets")
      @connection.exec("delete from retweets")
    end

    context 'fresh tweet' do
      it 'should enter the tweet in the tweet table' do
        User.new("aditya.sng93", "123", @connection).signup
        tweet = Tweet.new(@connection, "aditya.sng93")
        allow(Kernel).to receive(:gets).and_return("my tweet is being entered")
        expect(tweet.make_tweet).to_not eq(false)
      end

      it 'should have last tweet of the user as the currently entered tweet' do
        User.new("aditya.sng93", "123", @connection).signup
        tweet = Tweet.new(@connection, "aditya.sng93")
        allow(Kernel).to receive(:gets).and_return("my tweet is being entered now")
        tweet.make_tweet
        expect(STDOUT).to receive(:puts).with('my tweet is being entered now')
        tweet.display_tweet
      end
    end

    context 'retweet' do
      it 'should enter the retweeted tweet in the tweet table without asking user to input the tweet' do
        User.new("aditya.sng931", "123", @connection).signup
        tweet = Tweet.new(@connection, "aditya.sng931")
        allow(Tweet).to receive(:new).and_return(tweet)
        allow(Kernel).to receive(:gets).and_return("my tweet is being entered now")
        tweet.make_tweet
        allow(Kernel).to receive(:gets).and_return("1")
        expect(tweet.retweet).to_not eq(false)
      end
    end
  end
end