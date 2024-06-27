# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/words'

def head(strikes_left)
  return 'Ø' if strikes_left.zero?

  strikes_left < 6 ? 'O' : ''
end

def torso(strikes_left)
  strikes_left < 5 ? '|' : ''
end

def left_arm(strikes_left)
  strikes_left < 4 ? '/' : ' '
end

def right_arm(strikes_left)
  strikes_left < 3 ? '\\' : ''
end

def left_leg(strikes_left)
  strikes_left < 2 ? '/' : ' '
end

def right_leg(strikes_left)
  strikes_left.zero? ? '\\' : ''
end

def print_visual(strikes_left)
  sl = strikes_left
  puts '     ╔═════╗'
  puts '     ║     |'
  puts "     ║     #{head sl}"
  puts "     ║    #{left_arm sl}#{torso sl}#{right_arm sl}"
  puts "     ║    #{left_leg sl} #{right_leg sl}"
  puts '     ║'
  puts '  ═══╩═══'
end

def print_display(game)
  puts "\n" * 50
  puts "\nStrikes Left: #{game.strikes_left}"
  # puts "DEBUG - Secret Word: #{game.secret_word}"
  print_visual game.strikes_left
  puts "\n#{game.secret_word_hidden}"
  puts "\n#{game.incorrect_guesses}"
  puts "\n_____Options_____\n/m - Main Menu\n/x - Exit\nGuess a letter or word:"
end

secret_word = Words.random_word
game = Game.new secret_word

playing = true
while playing
  print_display game
  input = gets.chomp.downcase

  word_is_guessed = game.guess input
  p word_is_guessed

  playing = false if input == '/x' || game.strikes_left.zero? || word_is_guessed
end

print_display game
puts "\nSecret Word: #{game.secret_word}"
