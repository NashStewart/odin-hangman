# frozen_string_literal: true

# Utility for printing visuals, game info, and menu.
class Printer
  def initialize(game)
    @game = game
  end

  def print(menu: true)
    puts "\n" * 50
    print_visual
    print_info
    print_menu if menu
  end

  def print_end_game(word_is_guessed)
    print menu: false
    puts "\nThe secret word was:\n\n  #{@game.secret_word}\n"
    if word_is_guessed
      puts "\nYou guessed it! :)"
    else
      puts "\nYou lose. :("
    end
    puts "\nPress ENTER to Continue"
    gets
  end

  private

  def head
    return 'Ø' if @game.strikes_left.zero?

    @game.strikes_left < 6 ? 'O' : ''
  end

  def torso
    @game.strikes_left < 5 ? '|' : ''
  end

  def left_arm
    @game.strikes_left < 4 ? '/' : ' '
  end

  def right_arm
    @game.strikes_left < 3 ? '\\' : ''
  end

  def left_leg
    @game.strikes_left < 2 ? '/' : ' '
  end

  def right_leg
    @game.strikes_left.zero? ? '\\' : ''
  end

  def print_visual
    puts '     ╔═════╗'
    puts '     ║     |'
    puts "     ║     #{head}"
    puts "     ║    #{left_arm}#{torso}#{right_arm}"
    puts "     ║    #{left_leg} #{right_leg}"
    puts '     ║'
    puts '  ═══╩═══'
  end

  def print_info
    puts "Strikes Left: #{@game.strikes_left}"
    puts "\n#{@game.secret_word_hidden}"
    puts "\n#{@game.incorrect_guesses}"
  end

  def print_menu
    puts "\n_____Options_____\n/s - Save Game\n/m - Main Menu\nGuess a letter or word:"
  end
end
