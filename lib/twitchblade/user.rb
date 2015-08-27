require 'pg'

module Twitchblade
  class User
    attr_reader :count
    def initialize(username, password, connection)
      @username = username
      @password = password
      @connection = connection
      @@count = 0
    end

    def check_username_taken?
      result = @connection.exec("select * from user_info where user_name = '#{@username}'")
      if result.ntuples > 0
        true
      else
        false
      end
    end

    def signup
      result = @connection.exec("INSERT INTO user_info (user_name, password) VALUES ('#{@username}', '#{@password}')")
      @@count+=1
    end

  end
end