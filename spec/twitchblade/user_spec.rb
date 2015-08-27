require 'spec_helper.rb'

module Twitchblade
  describe 'user' do

    before(:all) do
      @connection = PG::Connection.open(:dbname => 'testing')
    end

    after(:each) do
      @connection.exec("delete from user_info")
    end

    context 'signup' do
      it 'should make insertion the record in the tuple' do
        user_1 = User.new("aditya.sng921", "123", @connection)
        expect(user_1.signup).to eq(true)
      end

      it 'should not insert the record in the tuple' do
        @connection.exec("INSERT INTO user_info (user_name, password) VALUES ('aditya', '111')")
        user_1 = User.new("aditya", "123", @connection)
        expect(user_1.signup).to eq(false)
      end
    end
  end
end
