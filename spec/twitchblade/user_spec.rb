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
      it 'should make insertion in the table' do
        user_1 = User.new("aditya.sng921", "123", @connection)
        expect(user_1.signup).to eq(true)
      end

      it 'should not insert the record in the tuple if username already exists' do
        @connection.exec("INSERT INTO user_info (user_name, password) VALUES ('aditya', '111')")
        user_1 = User.new("aditya", "123", @connection)
        expect(user_1.signup).to eq(false)
      end

      context 'login' do
        it 'should fail if username does not exist' do
          user_1 = User.new("aditya", "123", @connection)
          expect(user_1.login).to eq(false)
        end

        it 'should fail if username and password do not match' do
          @connection.exec("INSERT INTO user_info (user_name, password) VALUES ('aditya', '111')")
          user_1 = User.new("aditya", "123", @connection)
          expect(user_1.login).to eq(false)
        end

        it 'should pass if username and password do not match' do
          @connection.exec("INSERT INTO user_info (user_name, password) VALUES ('aditya', '111')")
          user_1 = User.new("aditya", "111", @connection)
          expect(user_1.login).to eq(true)
        end

        context 'logout' do
          it 'should make logged_in false' do
            @connection.exec("INSERT INTO user_info (user_name, password) VALUES ('aditya', '111')")
            user_1 = User.new("aditya", "111", @connection)
            user_1.login
            user_1.logout
            expect(user_1.logged_in).to eq(false )
          end
        end
      end
    end
  end
end
