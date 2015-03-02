require_relative 'response'
require_relative 'printer'
require_relative 'validity_checker'

class MastermindShell

  def initialize
    @printer = Printer.new
    @validity_checker = ValidityChecker.new
  end

  def intro
    @printer.intro
  end

  def menu_direction(input)
    if @validity_checker.play?(input)
      Response.new(:message => @printer.game_intro, :status => :start_game)
    elsif @validity_checker.instructions?(input)
      Response.new(:message => @printer.instructions, :status => :start_game)
    elsif @validity_checker.quit?(input)
      Response.new(:message => @printer.good_bye, :status => :quit)
    else
      Response.new(:message =>@printer.invalid_intro_response, :status => :stay_in_shell)
    end
  end
end
