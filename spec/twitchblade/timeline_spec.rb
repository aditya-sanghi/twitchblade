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

    it 'should retrieve all the tweets of the desired user name if the user exits' do
      timeline = Timeline.new(@connection)
      user_1 = User.new("aditya.sng931", "123", @connection).signup
      tweet = Tweet.new(@connection, "aditya.sng931")
      allow(Kernel).to receive(:gets).and_return("tweet1", "tweet2", "tweet3")
      tweet.make_tweet
      tweet.make_tweet
      tweet.make_tweet
      tweet_array = timeline.get_timeline("aditya.sng931")
      expect(tweet_array).to match_array ["tweet1", "tweet2", "tweet3"]
    end


    it 'should return false for timeline if the user does not exist' do
      timeline = Timeline.new(@connection)
      expect(timeline.get_timeline("foo_user")).to eq(false)
    end


  end
end