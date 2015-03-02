require_relative 'response'
require_relative 'timer'
require_relative 'printer'
require_relative 'validity_checker'

class Mastermind
  attr_accessor :sequence
  attr_reader :guess_count

  def initialize
    @sequence = generate_sequence
    @guess_count = 0
    @printer = Printer.new
    @timer = Timer.new
    @timer.start_timer
    @validity_checker = ValidityChecker.new
  end

  def generate_sequence
    colors = ["r", "g", "b", "y"]
    random_sequence = []
    4.times do
      random_sequence << colors.sample
    end
    random_sequence
  end

  def check_validity_of_guess(input)
    if @validity_checker.quit?(input)
      Response.new(:message => @printer.good_bye, :status => :quit) #quit game
    elsif @validity_checker.cheat?(input)
      Response.new(:message => "\nThe correct answer is '#{@sequence.join}'. Please enter:\n>", :status => :retry)
    elsif @validity_checker.too_long?(input)
      Response.new(:message => @printer.too_long, :status => :retry)
    elsif @validity_checker.too_short?(input)
      Response.new(:message => @printer.too_short, :status => :retry)
    elsif @validity_checker.appropriate_chars?(input)
      Response.new(:message => "", :status => :continue)
    else
      Response.new(:message => @printer.invalid_response, :status => :retry)
    end
  end

  def give_correct_elements(input)
    guess = input.dup
    @sequence.each do |color|
      if guess.index(color) != nil
        guess.delete_at(guess.index(color))
      end
    end
    4 - guess.size
  end

  def give_correct_positions(input)
    correct_position_counter = @sequence.zip(input).count do |position|
      position[0] == position[1]
    end
    correct_position_counter
  end

  def correct_guess
    @timer.end_timer
    Response.new(:message => @printer.congrats_message(@sequence.join, @guess_count, @timer.game_time_mins, @timer.game_time_seconds ), :status => :won)
  end

  def wrong_guess(input)
    correct_elements = give_correct_elements(input.chars)
    correct_positions = give_correct_positions(input.chars)
    Response.new(:message => @printer.guess_again(input, correct_elements, correct_positions), :status => :guess_again)
  end

  def execute(input)
    @guess_count += 1
    if input.chars == @sequence
      correct_guess
    else
      wrong_guess(input)
    end
  end
end
