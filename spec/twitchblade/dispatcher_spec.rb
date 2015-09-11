require 'spec_helper'
module Twitchblade

  describe 'Dispatcher' do

    before(:all) do
      @connection = PG::Connection.open(:dbname => 'testing')
    end

    context 'Guest or Not Logged-In User' do
      it 'should be able to create a new user' do
        dispatcher = Dispatcher.new(@connection, 1)
        allow(Kernel).to receive(:gets).and_return("aditya", "pass123")
        expect(User).to receive(:new).and_return(User.new("aditya", "pass123", @connection))
        dispatcher.invoke_feature
      end

      it 'should be able to call signup feature' do
        dispatcher = Dispatcher.new(@connection, 1)
        user = User.new("aditya", "pass123", @connection)
        allow(User).to receive(:new).and_return(user)
        allow(Kernel).to receive(:gets).and_return("aditya", "pass123")
        expect(user).to receive(:signup)
        dispatcher.invoke_feature
      end

      it 'should be able to call login feature' do
        dispatcher = Dispatcher.new(@connection, 2)
        user = User.new("aditya", "pass123", @connection)
        allow(Kernel).to receive(:gets).and_return("aditya", "pass123",)
        allow(User).to receive(:new).and_return(user)
        expect(user).to receive(:login)
        dispatcher.invoke_feature
      end

      it 'should be able to call timeline feature' do
        dispatcher = Dispatcher.new(@connection, 3)
        timeline = Timeline.new(@connection)
        allow(Kernel).to receive(:gets).and_return("aditya")
        allow(Timeline).to receive(:new).and_return(timeline)
        expect(timeline).to receive(:get_timeline)
        dispatcher.invoke_feature
      end
    end

    context "Logged-In user" do
      it 'should be able to call logout feature for the user' do
        dispatcher = Dispatcher.new(@connection, 2)
        user = User.new("aditya", "pass123", @connection)
        allow(Kernel).to receive(:gets).and_return("aditya", "pass123", 7)
        allow(User).to receive(:new).and_return(user)
        expect(user).to receive(:logout)
        dispatcher.invoke_feature
      end

      it 'should be able to call tweet feature for the user' do
        dispatcher = Dispatcher.new(@connection, 2)
        User.new("aditya1", "pass123", @connection).signup
        allow(Kernel).to receive(:gets).and_return("aditya1", "pass123", 1, "my tweet", 7)
        tweet = Tweet.new(@connection, "aditya1")
        allow(Tweet).to receive(:new).and_return(tweet)
        expect(tweet).to receive(:make_tweet)
        dispatcher.invoke_feature
      end

      it 'should be able to call the logged in users own timeline ' do
        dispatcher = Dispatcher.new(@connection, 2)
        timeline = Timeline.new(@connection)
        User.new("aditya1", "pass123", @connection).signup
        allow(Kernel).to receive(:gets).and_return("aditya1", "pass123", 2, 7)
        allow(Timeline).to receive(:new).and_return(timeline)
        expect(timeline).to receive(:get_timeline)
        dispatcher.invoke_feature
      end

      it "should be able to call someone else's timeline for the logged in user" do
        dispatcher = Dispatcher.new(@connection, 2)
        timeline = Timeline.new(@connection)
        User.new("aditya1", "pass123", @connection).signup
        allow(Kernel).to receive(:gets).and_return("aditya1", "pass123", 3, "aditya2", 7)
        allow(Timeline).to receive(:new).and_return(timeline)
        expect(timeline).to receive(:get_timeline)
        dispatcher.invoke_feature
      end


      it "should be able to call the follow feature" do
        dispatcher = Dispatcher.new(@connection, 2)
        user = User.new("aditya1", "pass123", @connection)
        user.signup
        allow(Kernel).to receive(:gets).and_return("aditya1", "pass123", 4, "aditya2", 7)
        allow(User).to receive(:new).and_return(user)
        expect(user).to receive(:follow)
        dispatcher.invoke_feature
      end
    end
  end
end