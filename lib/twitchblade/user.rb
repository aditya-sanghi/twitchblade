module Twitchblade
  #job of class is to model a twitchblade user!
  #state of class are username and password

  class User
    attr_reader :logged_in

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
        insertion = @connection.exec_params("INSERT INTO user_info (user_name, password) VALUES ($1, $2)", [@username, @password])
        insertion.cmd_tuples > 0 ? true : false
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

    def logout
      if @logged_in
        @logged_in = false
        true
      else
        false
      end
    end

    def follow(follow_user_name)
      user_id = @connection.exec("select user_id from user_info where user_name = '#{@username}'").field_values('user_id')[0].to_i
      follow_user_id = @connection.exec("select user_id from user_info where user_name = '#{follow_user_name}'").field_values('user_id')[0].to_i
      if follow_user_id != 0
        @connection.exec_params("INSERT INTO FOLLOWERS (user_id, following_user_id) VALUES ($1, $2)", [user_id, follow_user_id])
        true
      else
        false
      end
    end
  end
end