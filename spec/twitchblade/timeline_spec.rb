require 'spec_helper'

module Twitchblade

  describe 'Timeline' do
    before(:all) do
      @connection = PG::Connection.open(:dbname => 'testing')
    end

    after(:each) do
      @connection.exec("delete from user_info")
      @connection.exec("delete from tweets")
    end

    it 'should retrieve all the tweets of the desired user name if any tweets for that user exist' do
      User.new("aditya.sng931", "123", @connection).signup
      tweet = Tweet.new(@connection, "aditya.sng931")
      allow($stdin).to receive(:gets).and_return("tweet1", "tweet2", "tweet3")
      tweet.make_tweet
      tweet.make_tweet
      tweet.make_tweet
      tweet_array = Timeline.new(@connection, "aditya.sng931").get_timeline
      expect(tweet_array).to match_array ["tweet1", "tweet2", "tweet3"]
    end


    it 'should return false for timeline if the user does not exist' do
      timeline = Timeline.new(@connection, "foo_user")
      expect(timeline.get_timeline).to eq(false)
    end


    it 'should return false for timeline if there are no tweets on users timeline' do
      user_1 = User.new("aditya.sng931", "123", @connection).signup
      expect(Timeline.new(@connection, "aditya.sng931").get_timeline).to eq(false)
    end


    it 'should display all the tweets of the desired if any tweets for that user exist' do
      user_1 = User.new("aditya.sng931", "123", @connection).signup
      tweet = Tweet.new(@connection, "aditya.sng931")
      allow($stdin).to receive(:gets).and_return("tweet1", "tweet2", "tweet3")
      tweet_1 = tweet.make_tweet
      tweet_2 = tweet.make_tweet
      tweet_3 = tweet.make_tweet
      tweet_array = Timeline.new(@connection, "aditya.sng931").get_timeline
      pending(STDOUT).to receive(:puts).with("#{tweet_1}", "tweet1", "#{tweet_2}", "tweet2", "#{tweet_3}", "tweet3")
      timeline.display_timeline("aditya.sng931")
    end
  end
end