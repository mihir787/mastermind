require 'minitest/autorun'
require 'minitest/pride'
require_relative 'mastermind_shell'

class MastermindShellTest < Minitest::Test

  def setup
    @mms = MastermindShell.new
  end

  def test_it_exists
    assert @mms
  end

  def test_prints_intro
    assert_equal "\nWelcome to MASTERMIND!\nWould you like to (p)lay, read the (i)nstructions, or (q)uit?\n>", @mms.intro
  end

  def test_when_play_is_input_that_the_status_changes_to_start_game
    input = "play"
    response = @mms.menu_direction(input)
    assert_equal :start_game, response.status
  end

  def test_when_input_is_invalid_response
    input = "xygy"
    response = @mms.menu_direction(input)
    assert_equal :stay_in_shell, response.status
  end
end
