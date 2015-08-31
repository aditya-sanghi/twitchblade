require 'spec_helper'
module Twitchblade

  describe 'cli' do

    before(:all) do
      @connection = PG::Connection.open(:dbname => 'testing')
    end

    context 'should call twitchblade features based on user input' do
      it 'should create a new user' do
        cli = Cli.new(@connection)
        allow(Kernel).to receive(:gets).and_return(1, "aditya", "pass123")
        expect(User).to receive(:new).and_return(User.new("aditya", "pass123", @connection))
        cli.take_input_and_call_feature

      end

      it 'should call signup feature for the user' do
        cli = Cli.new(@connection)
        user = User.new("aditya", "pass123", @connection)
        allow(Kernel).to receive(:gets).and_return(1, "aditya", "pass123",)
        allow(User).to receive(:new).and_return(user)
        expect(user).to receive(:signup)
        cli.take_input_and_call_feature
      end


      it 'should call login feature for the user' do
        cli = Cli.new(@connection)
        user = User.new("aditya", "pass123", @connection)
        allow(Kernel).to receive(:gets).and_return(2, "aditya", "pass123",)
        allow(User).to receive(:new).and_return(user)
        expect(user).to receive(:login)
        cli.take_input_and_call_feature
      end

      it 'should call login feature for the user' do
        cli = Cli.new(@connection)
        user = User.new("aditya", "pass123", @connection)
        allow(Kernel).to receive(:gets).and_return(2, "aditya", "pass123", 1)
        allow(User).to receive(:new).and_return(user)
        expect(user).to receive(:logout)
        cli.take_input_and_call_feature
      end
    end
  end
end