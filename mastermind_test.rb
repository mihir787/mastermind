require 'minitest/autorun'
require 'minitest/pride'
require_relative 'mastermind'
require_relative 'response'

class MastermindTest < Minitest::Test

  def test_it_exists
    mm = Mastermind.new
    assert mm
  end

  def test_that_when_initialized_a_random_sequence_attribute_is_accessible
    mm = Mastermind.new
    mm.sequence
    assert mm.sequence
  end

  def test_initializes_with_random_sequence
    #not sure how to test this
    skip
    mm = Mastermind.new
    refute_equal ["r", "g", "b", "y"], mm.sequence
  end

  def test_the_validity_of_guess_of_long_answer
    mm = Mastermind.new
    guess = 'rgbyy'
    response = mm.check_validity_of_guess(guess)
    message = response.message
    assert_equal "\nAnswer is too long! Please enter 4 colors: (r)ed, (g)reen, (b)lue, and (y)ellow.\n>", message
  end

  def test_that_cheat_provides_answer
    mm = Mastermind.new
    mm.sequence = %w(r r r r)
    guess = 'cheat'
    response = mm.check_validity_of_guess(guess)
    message = response.message
    assert_equal "\nThe correct answer is 'rrrr'. Please enter:\n>", message
  end

  def test_the_validity_of_guess_of_short_answer
    mm = Mastermind.new
    guess = 'rby'
    response = mm.check_validity_of_guess(guess)
    message = response.message
    assert_equal "\nAnswer is too short! Please enter 4 colors: (r)ed, (g)reen, (b)lue, and (y)ellow.\n>", message
  end

  def test_the_validity_of_guess_that_is_four_characters_with_other_characters
    mm = Mastermind.new
    guess = 'rxyb'
    response = mm.check_validity_of_guess(guess)
    message = response.message
    assert_equal "\nInvalid Response! Remember the color choices are (r)ed, (g)reen, (b)lue, and (y)ellow.
Press (q)uit at anytime to quit the game or (c)heat to display the answer.\n>", message
  end

  def test_if_q_then_game_quits
    mm = Mastermind.new
    guess = 'q'
    response = mm.check_validity_of_guess(guess)
    status = response.status
    assert_equal :quit, status
  end

  def test_if_guess_meets_requirments
    mm = Mastermind.new
    guess = 'rygb'
    response = mm.check_validity_of_guess(guess)
    status = response.status
    assert :continue, status
  end

  def test_it_gives_number_of_correct_elements
    mm = Mastermind.new
    mm.sequence = %w(r g b b)
    guess = %w(r b y b)
    assert_equal 3, mm.give_correct_elements(guess)
  end

  def test_it_gives_number_of_correct_elements
    mm = Mastermind.new
    mm.sequence = %w(r g g g)
    guess = %w(r r r g)
    assert_equal 2, mm.give_correct_elements(guess)
  end

  def test_elements_if_sequence_and_guess_same
    mm = Mastermind.new
    mm.sequence = %w(r b y b)
    guess = %w(r b y b)
    assert_equal 4, mm.give_correct_elements(guess)
  end

  def test_positions
    mm = Mastermind.new
    mm.sequence = %w(r b y b)
    guess = %w(g b y r)
    assert_equal 2, mm.give_correct_positions(guess)
  end

  def test_positions_if_guess_and_sequence_same
    mm = Mastermind.new
    mm.sequence = %w(r b y b)
    guess = %w(r b y b)
    assert_equal 4, mm.give_correct_positions(guess)
  end

  def test_execution_of_non_winning_sequence
    mm = Mastermind.new
    mm.sequence = %w(r b y b)
    guess = 'rbyb'
    response = mm.execute(guess)
    assert_equal :won, response.status
  end

  def test_execution_of_winning_sequence_after_multiple_executions
    mm = Mastermind.new
    mm.sequence = %w(r b y b)
    guess = 'rbyy'
    guess_two = 'rbyb'
    response = mm.execute(guess)
    assert_equal :guess_again, response.status
    response = mm.execute(guess_two)
    assert_equal :won, response.status
  end

  def test_can_count_number_of_valid_guesses
    mm = Mastermind.new
    mm.sequence = %w(r b y b)
    guess = 'rbyy'
    guess_two = 'rbyb'
    mm.execute(guess)
    mm.execute(guess_two)
    assert_equal 2, mm.guess_count
  end
end
