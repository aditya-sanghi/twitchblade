require 'spec_helper.rb'

module Twitchblade
  describe 'user' do

    before(:all) do
      @connection = PG::Connection.open(:dbname => 'testing')
    end

    before(:each) do
      @user_1 = User.new("aditya.sng911", "123", @connection)
      @connection.exec("insert into user_info (user_name, password) values ('aditya.sng911', '123')")
    end

    after(:each) do
      @connection.exec("delete from user_info")
    end

    context "#username_available?" do
      it "will check if user already exits" do
        expect(@user_1.username_taken?).to eq(true)
      end

    end
  end
end
