require_relative 'mastermind'
require_relative 'mastermind_shell'


shell = MastermindShell.new
print shell.intro
status = nil
until status == :quit
  mastermind = Mastermind.new
  input = gets.chomp
  response = shell.menu_direction(input)
  message = response.message
  status = response.status
  print message
  if status == :start_game
    until status == :won || status == :quit
      input = gets.chomp
      response = mastermind.check_validity_of_guess(input)
      message = response.message
      status = response.status
      print message
      if status == :continue
        feedback = mastermind.execute(input)
        message = feedback.message
        status = feedback.status
        print message
      end
    end
    status
  end
end
