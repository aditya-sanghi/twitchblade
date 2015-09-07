require 'spec_helper'
module Twitchblade

  describe 'cli' do

    before(:all) do
      @connection = PG::Connection.open(:dbname => 'testing')
    end

    context 'should call twitchblade features based on user input' do

      
    end
  end
end