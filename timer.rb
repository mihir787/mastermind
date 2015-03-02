class Timer
  def initialize
    @start_time = nil
    @end_time = nil
  end

  def start_timer
    @start_time = Time.now
  end

  def end_timer
    @end_time = Time.now
  end

  def total_game_time
    (@end_time - @start_time).to_i
  end

  def game_time_mins
    (total_game_time / 60).floor
  end

  def game_time_seconds
    (total_game_time % 60).ceil
  end
end
