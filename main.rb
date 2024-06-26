# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/words'

secret_word = Words.random_word
game = Game.new secret_word

p game
game.guess_letter('a')
p game
game.guess_letter('e')
p game
game.guess_letter('i')
p game
game.guess_letter('o')
p game
game.guess_letter('o') # Redundant guess
p game
# game.guess_letter('u')
# p game
# game.guess_letter('y') # Sixth guess
# p game
# game.guess_letter('x') # Seventh guess
#p game

puts

incorrect_word = 'bubble'
p incorrect_word
game.guess_word incorrect_word
p game
game.guess_word incorrect_word # Redundant guess
p game
puts game.secret_word

puts

correct_word = game.debug_secret_word.clone
p correct_word
game.guess_word correct_word
p game
puts game.secret_word
