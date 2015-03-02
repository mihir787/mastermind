class ValidityChecker

  def play?(input)
    input == "p" || input == "play"
  end

  def instructions?(input)
    input == "i"
  end

  def quit?(input)
    input == "q" || input == "quit"
  end

  def cheat?(input)
    input == "c" || input == "cheat"
  end

  def too_short?(input)
    input.chars.size < 4
  end

  def too_long?(input)
    input.chars.size > 4
  end

  def appropriate_chars?(input)
    input.chars.all? {|l| l =="r" || l =="g" || l== "b" || l== "y"}
  end
end
