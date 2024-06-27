# frozen_string_literal: true

# Object to keep track of game state.
class Game
  attr_reader :correct_guesses, :incorrect_guesses

  def initialize(secret_word)
    @secret_word = secret_word
    @correct_guesses = []
    @incorrect_guesses = []
  end

  def guess(string)
    return unless counts? string

    if string.length == 1
      @secret_word.include?(string) ? @correct_guesses << string : @incorrect_guesses << string
    else
      @secret_word == string ? @correct_guesses << string : @incorrect_guesses << string
    end
  end

  def secret_word
    return @secret_word.split('').join(' ') if @correct_guesses.include? @secret_word

    @secret_word.split('').map { |char| @correct_guesses.include?(char) ? "#{char} " : '_ ' }.join
  end

  def debug_secret_word
    @secret_word
  end

  private

  def counts?(string)
    guesses_left? && alpha_only?(string) && unique?(string)
  end

  def alpha_only?(string)
    string.is_a?(String) && string.match?(/\A[a-z]*\z/)
  end

  def guesses_left?
    incorrect_guesses.size < 6
  end

  def unique?(string)
    !correct_guesses.include?(string) && !incorrect_guesses.include?(string)
  end
  # x Make a letter guess
  # x Make a word guess
  # x Get player version of secret_word
  # - Serialize
  # - Deserialize
end
