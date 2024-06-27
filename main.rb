# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/words'

def debug(game)
  p game
  game.guess('a')
  p game
  game.guess('e')
  p game
  game.guess('i')
  p game
  game.guess('o')
  p game
  game.guess('o') # Redundant guess
  p game
  game.guess('u')
  p game
  game.guess('y') # Sixth guess
  p game
  game.guess('x') # Seventh guess
  p game

  puts

  incorrect_word = 'bubble'
  p incorrect_word
  game.guess incorrect_word
  p game
  game.guess nil # Redundant guess
  p game
  puts game.secret_word

  puts

  correct_word = game.debug_secret_word.clone
  p correct_word
  game.guess correct_word
  p game
  puts game.secret_word
end

def print_game_display(game)
  puts "\n" * 50
  puts "Strikes Left: #{game.incorrect_guesses.size}"
  puts game.secret_word
  puts "\n/m - menu\n/x - exit\nGuess a letter or word:"
end

secret_word = Words.random_word
game = Game.new secret_word

playing = true
while playing
  print_game_display game
  input = gets.chomp.downcase

  playing = false if input == '/x'
end

# Strikes Left: 0
#
#     ╔═════╗
#     ║     |
#     ║     Ø
#     ║    /|\
#     ║    /\
#     ║
#  ═══╩═══
#
#  _ A _ D A _ _

# debug game
