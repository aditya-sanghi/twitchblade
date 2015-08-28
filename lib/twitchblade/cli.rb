module Twitchblade
  #job of class is to call twitchblade functionality from
  class Cli

    def initialize(connection = nil)
      @connection = connection
    end

    def take_input_and_call_feature
      puts "Menu"
      puts "1. Signup"
      puts "enter option: "
      command = Kernel.gets
      if command.to_i == 1
        puts "enter new username: "
        username = Kernel.gets
        puts "enter new password: "
        password = Kernel.gets
        new_user = User.new(username, password, @connection)
        new_user.signup
      else
        puts "invalid input"
        exit
      end
    end
  end
end