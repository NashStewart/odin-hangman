# frozen_string_literal: true

# Object to keep track of game state.
class Game
  attr_reader :correct_guesses, :guesses_left, :incorrect_guesses, :secret_word

  def initialize(secret_word)
    @secret_word = secret_word
    @guesses_left = 6
    @correct_guesses = []
    @incorrect_guesses = []
  end

  def guess_letter(letter)
    @secret_word.include?(letter) ? @correct_guesses << letter : @incorrect_guesses << letter
  end

  def word_is?(word)
    @secret_word == word
  end

  # x Make a letter guess
  # x Make a word guess
  # - Get player version of secret_word
  # - Serialize
  # - Deserialize
end
