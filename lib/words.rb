# frozen_string_literal: true

# Utility for serving a random word from a file.
module Words
  module_function

  def random_word
    five_to_twelve_letters = /\A[a-z]{5,12}\z/
    words = words_from_file
    word = ''
    word = words.sample.gsub("\n", '') until word.match? five_to_twelve_letters
    word
  end

  def words_from_file
    File.readlines 'google-10000-english-no-swears.txt'
  rescue StandardError
    'ERROR - Could not load file'
  end
end
