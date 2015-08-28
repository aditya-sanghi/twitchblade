require 'spec_helper'
module Twitchblade
  describe 'cli' do

    context 'call twitchblade features based on user input' do
      it 'should create a new user' do
        cli = Cli.new
        allow(Kernel).to receive(:gets).and_return("pass123")
        allow(Kernel).to receive(:gets).and_return("aditya")
        allow(Kernel).to receive(:gets).and_return(1)
        expect(User).to receive(:new)
        cli.take_input_and_call_feature

      end
    end
  end
end