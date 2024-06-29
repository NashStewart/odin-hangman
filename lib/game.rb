# frozen_string_literal: true

# Object to keep track of game state.
class Game
  attr_reader :secret_word

  def initialize(secret_word)
    @secret_word = secret_word
    @correct_guesses = []
    @incorrect_guesses = []
  end

  def guess(string)
    return unless counts? string
    return true if @secret_word == string

    if string.length == 1 && @secret_word.include?(string)
      @correct_guesses << string
    else
      @incorrect_guesses << string
    end
    @secret_word.split('').difference(@correct_guesses).empty?
  end

  def secret_word_hidden
    return @secret_word.split('').join(' ') if @correct_guesses.include? @secret_word

    @secret_word.split('').map { |char| @correct_guesses.include?(char) ? " #{char}" : ' _' }.join
  end

  def strikes_left
    6 - @incorrect_guesses.size
  end

  def incorrect_guesses
    @incorrect_guesses.reduce(' ') { |string, guess| string + "#{guess}, " }
  end

  def marshal_dump
    [@secret_word, @correct_guesses, @incorrect_guesses]
  end

  def marshal_load(array)
    @secret_word, @correct_guesses, @incorrect_guesses = array
  end

  def to_s
    [@secret_word, @correct_guesses, @incorrect_guesses].to_s
  end

  private

  def counts?(string)
    strikes_left.positive? && alpha_only?(string) && unique?(string)
  end

  def alpha_only?(string)
    string.is_a?(String) && string.match?(/\A[a-z]*\z/)
  end

  def unique?(string)
    !@correct_guesses.include?(string) && !@incorrect_guesses.include?(string)
  end
end
