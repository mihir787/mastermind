require_relative 'response'
require_relative 'printer'

class MastermindShell

  def initialize
    @printer = Printer.new
  end

  def intro
    @printer.intro
  end

  def menu_direction(input)
    if input == "p" || input == "play"
      Response.new(:message => @printer.game_intro, :status => :start_game)
    elsif input == "i"
      Response.new(:message => @printer.instructions, :status => :start_game)
    elsif input == "q" || input == "quit"
      Response.new(:message => @printer.good_bye, :status => :quit)
    else
      Response.new(:message =>@printer.invalid_intro_response, :status => :stay_in_shell)
    end
  end
end
