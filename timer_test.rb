require 'minitest/autorun'
require 'minitest/pride'
require_relative 'timer'

class TimerTest < Minitest::Test

  def test_that_it_exists
    timer = Timer.new
    assert timer
  end

  def test_that_a_start_time_is_set
    timer = Timer.new
    refute_equal nil, timer.start_timer
  end

  def test_that_a_end_time_is_set
    timer = Timer.new
    refute_equal nil, timer.end_timer
  end

end
