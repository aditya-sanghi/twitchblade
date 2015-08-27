require 'pg'

module Twitchblade
  class User
    def initialize(username, password, connection)
      @username = username
      @password = password
      @connection = connection
    end

    def username_taken?
      result = @connection.exec("select * from user_info where user_name = '#{@username}'")
      if result.ntuples > 0
        true
      else
        false
      end
    end
  end
end