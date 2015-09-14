require 'spec_helper.rb'

module Twitchblade
  describe 'User' do

    before(:all) do
      @connection = PG::Connection.open(:dbname => 'testing')
    end

    after(:each) do
      @connection.exec("delete from user_info")
    end

    context 'signup' do
      it 'should register a new username and return true' do
        user_1 = User.new("aditya.sng921", "123", @connection)
        expect(user_1.signup).to eq(true)
      end

      it 'should not insert the record in the tuple if username already exists' do
        user_1 = User.new("aditya", "123", @connection)
        user_1.signup
        user_2 = User.new("aditya", "123", @connection)
        expect(user_2.signup).to eq(false)
      end
    end

    context 'after login' do
      it 'should fail if username does not exist' do
        user_1 = User.new("aditya", "123", @connection)
        expect(user_1.login).to eq(false)
      end

      it 'should fail if username and password do not match' do
        user_1 = User.new("aditya", "123", @connection)
        user_1.signup
        user_2 = User.new("aditya", "wrongpassword", @connection)
        expect(user_2.login).to eq(false)
      end

      it 'should pass if username and password match' do
        user_1 = User.new("aditya", "123", @connection)
        user_1.signup
        user_2 = User.new("aditya", "123", @connection)
        expect(user_2.login).to eq(true)
      end

      context 'logout' do
        it 'should make logged_in false' do
          user_1 = User.new("aditya11", "111", @connection)
          user_1.signup
          user_1.login
          user_1.logout
          expect(user_1.logged_in).to eq(false)
        end
      end

      context 'follow' do
        it "should  make currently logged in user to follow another registered  user and return true" do
          user_1 = User.new("aditya", "111", @connection)
          user_1.signup
          user_2 = User.new("saim", "111", @connection)
          user_2.signup
          user_1.login
          expect(user_1.follow("saim")).to eq(true)
        end

        it "should return false if user to be followed does not exist" do
          user_1 = User.new("aditya", "111", @connection)
          user_1.signup
          user_1.login
          expect(user_1.follow("saim")).to eq(false)
        end

        it "should return false if the logged-in user is already following the entered user" do
          user_1 = User.new("aditya", "111", @connection)
          user_1.signup
          user_2 = User.new("saim", "111", @connection)
          user_2.signup
          user_1.login
          user_1.follow("saim")
          expect(user_1.follow("saim")).to eq(false)
        end


        it "should return all the users that are being followed by the logged-in user" do
          user_1 = User.new("aditya", "111", @connection)
          user_1.signup
          user_1.login
          User.new("saim", "111", @connection).signup
          user_1.follow("saim")
          expect(user_1.list_users_being_followed).to match_array ["saim"]
        end

        it "should return all the users that are following the logged-in user" do
          user_1 = User.new("aditya", "111", @connection)
          user_1.signup
          user_1.login
          user_2 = User.new("saim", "111", @connection)
          user_2.signup
          user_1.follow("saim")
          user_2.login
          expect(user_2.list_followers).to match_array ["aditya"]
        end
      end
    end
  end
end
