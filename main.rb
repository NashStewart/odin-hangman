# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/words'

secret_word = Words.random_word
game = Game.new secret_word

pp game
game.guess_letter('l')
pp game

incorrect_word = 'bubble'
correct_word = game.secret_word.clone
p incorrect_word
p correct_word
p game.word_is? incorrect_word
p game.word_is? correct_word
