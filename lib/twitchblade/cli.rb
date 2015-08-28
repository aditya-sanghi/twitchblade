module Twitchblade
  #job of class is to call twitchblade functionality from
  class Cli

    def initialize(connection = nil)
      @connection = connection
    end

    def take_input_and_call_feature
      puts "enter option: "
      command = Kernel.gets

      if command == 1
        puts "enter new username: "
        username = Kernel.gets

        puts "enter new password: "
        password = Kernel.gets

        new_user = User.new(username, password, @connection)
        #new_user.signup


      end
    end

  end
end