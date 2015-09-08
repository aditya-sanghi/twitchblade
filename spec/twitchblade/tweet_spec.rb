require 'spec_helper'
module Twitchblade

  describe 'dispatcher' do

    before(:all) do
      @connection = PG::Connection.open(:dbname => 'testing')
    end

    it 'should enter the tweet in the tweet table' do
      user_1 = User.new("aditya.sng93", "123", @connection).signup
      tweet = Tweet.new(@connection, "aditya.sng93")
      allow(Kernel).to receive(:gets).and_return("my tweet is being entered")
      expect(tweet.make_tweet).to eq(true)
    end
  end
end