require 'spec_helper'
module Twitchblade

  describe 'Dispatcher' do

    before(:all) do
      @connection = PG::Connection.open(:dbname => 'testing')
    end

    context 'should call twitchblade features based on argument passed to dispatcher' do
      it 'should create a new user' do
        dispatcher = Dispatcher.new(@connection, 1)
        allow(Kernel).to receive(:gets).and_return("aditya", "pass123")
        expect(User).to receive(:new).and_return(User.new("aditya", "pass123", @connection))
        dispatcher.invoke_feature
      end

      it 'should call signup feature for the user' do
        dispatcher = Dispatcher.new(@connection, 1)
        user = User.new("aditya", "pass123", @connection)
        allow(User).to receive(:new).and_return(user)
        allow(Kernel).to receive(:gets).and_return("aditya", "pass123")
        expect(user).to receive(:signup)
        dispatcher.invoke_feature
      end

      it 'should call login feature for the user' do
        dispatcher = Dispatcher.new(@connection, 2)
        user = User.new("aditya", "pass123", @connection)
        allow(Kernel).to receive(:gets).and_return("aditya", "pass123",)
        allow(User).to receive(:new).and_return(user)
        expect(user).to receive(:login)
        dispatcher.invoke_feature
      end

      it 'should call timeline feature for the guest user' do
        dispatcher = Dispatcher.new(@connection, 3)
        timeline = Timeline.new(@connection)
        allow(Kernel).to receive(:gets).and_return("aditya")
        allow(Timeline).to receive(:new).and_return(timeline)
        expect(timeline).to receive(:get_timeline)
        dispatcher.invoke_feature
      end

      it 'should call logout feature for the user' do
        dispatcher = Dispatcher.new(@connection, 2)
        user = User.new("aditya", "pass123", @connection)
        allow(Kernel).to receive(:gets).and_return("aditya", "pass123", 3)
        allow(User).to receive(:new).and_return(user)
        expect(user).to receive(:logout)
        dispatcher.invoke_feature
      end

      it 'should call tweet feature for the user' do
        dispatcher = Dispatcher.new(@connection, 2)
        User.new("aditya1", "pass123", @connection).signup
        allow(Kernel).to receive(:gets).and_return("aditya1", "pass123", 1, "my tweet", 3)
        tweet = Tweet.new(@connection, "aditya1")
        allow(Tweet).to receive(:new).and_return(tweet)
        expect(tweet).to receive(:make_tweet)
        dispatcher.invoke_feature
      end

      it 'should call the logged in users own timeline ' do
        dispatcher = Dispatcher.new(@connection, 2)
        timeline = Timeline.new(@connection)
        User.new("aditya1", "pass123", @connection).signup
        allow(Kernel).to receive(:gets).and_return("aditya1", "pass123", 2, 3)
        allow(Timeline).to receive(:new).and_return(timeline)
        expect(timeline).to receive(:get_timeline)
        dispatcher.invoke_feature
      end
    end
  end
end