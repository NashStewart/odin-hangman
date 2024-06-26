# frozen_string_literal: true

# Object to keep track of game state.
class Game
  attr_reader :correct_guesses, :guesses_left, :incorrect_guesses

  def initialize(secret_word)
    @secret_word = secret_word
    @guesses_left = 6
    @correct_guesses = []
    @incorrect_guesses = []
  end

  def guess_letter(letter)
    return unless guesses_left > 0
    return unless letter.length == 1
    return if already_guessed? letter

    @guesses_left -= 1
    @secret_word.include?(letter) ? @correct_guesses << letter : @incorrect_guesses << letter
  end

  def guess_word(word)
    return unless guesses_left > 0
    return unless word
    return if already_guessed? word

    @guesses_left -= 1
    @secret_word == word ? @correct_guesses << word : @incorrect_guesses << word 
  end

  def secret_word
    return @secret_word.split('').join(' ') if @correct_guesses.include? @secret_word
    @secret_word.split('').map { |char| @correct_guesses.include?(char) ? "#{char} " : "_ " }.join
  end

  def debug_secret_word
    @secret_word
  end

  private

  def already_guessed?(guess)
    correct_guesses.include?(guess) || incorrect_guesses.include?(guess)
  end
  # x Make a letter guess
  # x Make a word guess
  # x Get player version of secret_word
  # - Serialize
  # - Deserialize
end
