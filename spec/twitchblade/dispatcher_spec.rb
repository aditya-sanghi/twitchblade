require 'spec_helper'
module Twitchblade

  describe 'Dispatcher:' do

    before(:all) do
      @connection = PG::Connection.open(:dbname => 'testing')
    end

    context 'Guest User' do
      it 'should be able to create a new user' do
        dispatcher = Dispatcher.new(@connection, 1)
        allow($stdin).to receive(:gets).and_return("aditya", "pass123")
        expect(User).to receive(:new).and_return(User.new("aditya", "pass123", @connection))
        dispatcher.invoke_feature
      end

      it 'should be able to call signup feature' do
        dispatcher = Dispatcher.new(@connection, 1)
        user = User.new("aditya", "pass123", @connection)
        allow(User).to receive(:new).and_return(user)
        allow($stdin).to receive(:gets).and_return("aditya", "pass123")
        expect(user).to receive(:signup)
        dispatcher.invoke_feature
      end

      it 'should be able to call login feature' do
        dispatcher = Dispatcher.new(@connection, 2)
        user = User.new("aditya", "pass123", @connection)
        allow($stdin).to receive(:gets).and_return("aditya", "pass123",)
        allow(User).to receive(:new).and_return(user)
        expect(user).to receive(:login)
        dispatcher.invoke_feature
      end

      it 'should be able to call timeline feature' do
        dispatcher = Dispatcher.new(@connection, 3)
        timeline = Timeline.new(@connection, "aditya")
        allow($stdin).to receive(:gets).and_return("aditya")
        allow(Timeline).to receive(:new).and_return(timeline)
        expect(timeline).to receive(:get_timeline)
        dispatcher.invoke_feature
      end
    end

    context "Logged-In user" do
      it 'should be able to call logout feature for the user' do
        dispatcher = Dispatcher.new(@connection, 2)
        user = User.new("aditya", "pass123", @connection)
        allow($stdin).to receive(:gets).and_return("aditya", "pass123", 9)
        allow(User).to receive(:new).and_return(user)
        expect(user).to receive(:logout)
        dispatcher.invoke_feature
      end

      it 'should be able to call tweet feature for the user' do
        dispatcher = Dispatcher.new(@connection, 2)
        User.new("aditya1", "pass123", @connection).signup
        allow($stdin).to receive(:gets).and_return("aditya1", "pass123", 1, "my tweet", 9)
        tweet = Tweet.new(@connection, "aditya1")
        allow(Tweet).to receive(:new).and_return(tweet)
        expect(tweet).to receive(:make_tweet)
        dispatcher.invoke_feature
      end

      it 'should be able to call the logged in users own timeline ' do
        dispatcher = Dispatcher.new(@connection, 2)
        User.new("aditya1", "pass123", @connection).signup
        timeline = Timeline.new(@connection, "aditya1")
        allow($stdin).to receive(:gets).and_return("aditya1", "pass123", 2, 9)
        allow(Timeline).to receive(:new).and_return(timeline)
        expect(timeline).to receive(:get_timeline)
        dispatcher.invoke_feature
      end

      it "should be able to call someone else's timeline for the logged in user" do
        dispatcher = Dispatcher.new(@connection, 2)
        User.new("aditya1", "pass123", @connection).signup
        timeline = Timeline.new(@connection, "aditya1")
        allow($stdin).to receive(:gets).and_return("aditya1", "pass123", 3, "aditya2", 9)
        allow(Timeline).to receive(:new).and_return(timeline)
        expect(timeline).to receive(:get_timeline)
        dispatcher.invoke_feature
      end

      it "should be able to call the follow feature" do
        dispatcher = Dispatcher.new(@connection, 2)
        user = User.new("aditya1", "pass123", @connection)
        user.signup
        allow($stdin).to receive(:gets).and_return("aditya1", "pass123", 4, "aditya2", 9)
        allow(User).to receive(:new).and_return(user)
        expect(user).to receive(:follow)
        dispatcher.invoke_feature
      end

      it "should be able to call the feature to view list of people he is following" do
        dispatcher = Dispatcher.new(@connection, 2)
        user = User.new("aditya1", "pass123", @connection)
        user.signup
        allow($stdin).to receive(:gets).and_return("aditya1", "pass123", 5, 9)
        allow(User).to receive(:new).and_return(user)
        expect(user).to receive(:list_users_being_followed)
        dispatcher.invoke_feature
      end

      it "should be able to call the feature to view list of his followers" do
        dispatcher = Dispatcher.new(@connection, 2)
        user = User.new("aditya1", "pass123", @connection)
        user.signup
        allow($stdin).to receive(:gets).and_return("aditya1", "pass123", 6, 9)
        allow(User).to receive(:new).and_return(user)
        expect(user).to receive(:list_followers)
        dispatcher.invoke_feature
      end

      it "should be able to call the feature to view his wall" do
        dispatcher = Dispatcher.new(@connection, 2)
        user = User.new("aditya1", "pass123", @connection)
        user.signup
        allow($stdin).to receive(:gets).and_return("aditya1", "pass123", 7, 9)
        allow(User).to receive(:new).and_return(user)
        wall = Wall.new(@connection, "aditya1")
        allow(Wall).to receive(:new).and_return(wall)
        expect(wall).to receive(:display_wall)
        dispatcher.invoke_feature
      end

      it "should be able to call the feature to RETWEET" do
        dispatcher = Dispatcher.new(@connection, 2)
        User.new("aditya1", "pass123", @connection).signup
        allow($stdin).to receive(:gets).and_return("aditya1", "pass123", 8, "123", 9)
        tweet = Tweet.new(@connection, "aditya1")
        allow(Tweet).to receive(:new).and_return(tweet)
        expect(tweet).to receive(:retweet)
        dispatcher.invoke_feature
      end

      it "should be able to call the feature to DISPLAY RETWEET when retweeting an existing tweet" do
        @connection.exec("ALTER SEQUENCE tweets_tweet_id_seq RESTART WITH 1")
        dispatcher = Dispatcher.new(@connection, 2)
        User.new("aditya1", "pass123", @connection).signup
        tweet = Tweet.new(@connection, "aditya1")
        allow(Tweet).to receive(:new).and_return(tweet)
        allow($stdin).to receive(:gets).and_return("aditya1", "pass123", 1, "tweetforretweet", 8, 1, 9)
        expect(tweet).to receive(:display_retweet)
        dispatcher.invoke_feature
        @connection.exec("Delete from tweets")
      end


      it "should NOT be able to call the feature to DISPLAY RETWEET when retweeting an existing tweet" do
        @connection.exec("ALTER SEQUENCE tweets_tweet_id_seq RESTART WITH 1")
        dispatcher = Dispatcher.new(@connection, 2)
        User.new("aditya1", "pass123", @connection).signup
        tweet = Tweet.new(@connection, "aditya1")
        allow(Tweet).to receive(:new).and_return(tweet)
        allow($stdin).to receive(:gets).and_return("aditya1", "pass123", 1, "tweetforretweet", 8, 2, 9)
        expect(tweet).to_not receive(:display_retweet)
        dispatcher.invoke_feature
        @connection.exec("Delete from tweets")
      end
    end
  end
end