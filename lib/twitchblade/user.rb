require 'pg'

module Twitchblade
  class User
    def initialize(username, password, connection)
      @username = username
      @password = password
      @connection = connection
      @logged_in = false
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
        @connection.exec_params("INSERT INTO user_info (user_name, password) VALUES ($1, $2)", [@username, @password])
        username_present?
      else
        false
      end
    end


    def login
      if username_present? == false
        false
      else
        result = @connection.exec_params("select * from user_info where user_name = $1 and password = $2", [@username, @password])
        if result.ntuples > 0
          @logged_in = true
          true
        else
          false
        end
      end
    end

  end
end