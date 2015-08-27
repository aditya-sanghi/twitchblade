require 'pg'

module Twitchblade
  class User
    def initialize(username, password, connection)
      @username = username
      @password = password
      @connection = connection
    end

    private def username_present?
      result = @connection.exec("select * from user_info where user_name = '#{@username}'")
      if result.ntuples > 0
        true
      else
        false
      end
    end

    def signup
      if username_present? == false
        @connection.exec("INSERT INTO user_info (user_name, password) VALUES ('#{@username}', '#{@password}')")
        username_present?
      else
        false
      end
    end

  end
end