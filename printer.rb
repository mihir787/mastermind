class Printer

  def intro
    "\nWelcome to MASTERMIND!\nWould you like to (p)lay, read the (i)nstructions, or (q)uit?\n>"
  end

  def invalid_intro_response
    "\nInvalid response. Press (p)lay, read the (i)nstructions, or (q)uit?\n>"
  end

  def game_intro
    "\nI have generated a beginner sequence with four elements made up of: (r)ed,
(g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end the game and (c)heat to reveal the answer.
What's your guess?\n>"
  end

  def instructions
    "\nGuess the random computer generated pattern of colors in both order and color.
The color choices are (r)ed, (g)reen, (b)lue, and (y)ellow. Press (q)uit at anytime
or (c)heat to display the answer.
#{game_intro}"
  end

  def play_again
    "\nDo you want to (p)lay again or (q)uit?\n>"
  end

  def good_bye
    "\nGoodbye!\n"
  end

  def invalid_response
    "\nInvalid Response! Remember the color choices are (r)ed, (g)reen, (b)lue, and (y)ellow.
Press (q)uit at anytime to quit the game or (c)heat to display the answer.\n>"
  end

  def too_long
    "\nAnswer is too long! Please enter 4 colors: (r)ed, (g)reen, (b)lue, and (y)ellow.\n>"
  end

  def too_short
    "\nAnswer is too short! Please enter 4 colors: (r)ed, (g)reen, (b)lue, and (y)ellow.\n>"
  end

  def play_again
    "Do you want to (p)lay again or (q)uit?"
  end

end
