require 'spec_helper.rb'

module Twitchblade
  describe 'user' do

    before(:all) do
      @connection = PG::Connection.open(:dbname => 'testing')
    end

    before(:each) do
      @connection.exec("insert into user_info (user_name, password) values ('aditya.sng911', '123')")
    end

    after(:each) do
      @connection.exec("delete from user_info")
    end

    context "#check_username_taken?" do
      it "should return true if user already exits" do
        user_1 = User.new("aditya.sng911", "123", @connection)
        expect(user_1.check_username_taken?).to eq(true)
      end

      it 'should return false if user does not exist' do
        user_1 = User.new("aditya.sng921", "123", @connection)
        expect(user_1.check_username_taken?).to eq(false)
      end
    end

    context 'signup' do
      it 'should make insert the record in the tuple' do
        user_1 = User.new("aditya.sng921", "123", @connection)
        user_record = user_1.signup
        user_2 = User.new("aditya.sng921", "123", @connection)
        expect(user_2.check_username_taken?).to eq(true)
      end
    end
  end
end
