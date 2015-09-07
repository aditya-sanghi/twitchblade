require 'spec_helper'
module Twitchblade

  describe 'dispatcher' do

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
    end
  end
end