require_relative 'response'
require_relative 'timer'
require_relative 'printer'

class Mastermind
  attr_accessor :sequence
  attr_reader :guess_count

  def initialize
    @sequence = generate_sequence
    @guess_count = 0
    @printer = Printer.new
    @timer = Timer.new
    @timer.start_timer
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
    if input == "q" || input == "quit"
      Response.new(:message => @printer.good_bye, :status => :quit) #quit game
    elsif input == "c" || input == "cheat"
      Response.new(:message => "\nThe correct answer is '#{@sequence.join}'. Please enter:\n>", :status => :retry)
    elsif input.chars.size > 4
      Response.new(:message => @printer.too_long, :status => :retry)
    elsif input.chars.size < 4
      Response.new(:message => @printer.too_short, :status => :retry)
    elsif input.chars.all? {|l| l =="r" || l =="g" || l== "b" || l== "y"}
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

  def execute(input)
    @guess_count += 1
    if input.chars == @sequence
      @timer.end_timer
      Response.new(:message => "\nCongratulations! You guessed the sequence '#{@sequence.join}' in #{@guess_count} guesses over
#{@timer.game_time_mins} minutes and #{@timer.game_time_seconds} seconds.
#{@printer.play_again}\n>", :status => :won)
    else
      correct_elements = give_correct_elements(input.chars)
      correct_positions = give_correct_positions(input.chars)
      Response.new(:message => "\n'#{input}' has #{correct_elements} of the correct elements with #{correct_positions} in the correct positions. Please guess again.\n>", :status => :guess_again)
    end
  end
end
