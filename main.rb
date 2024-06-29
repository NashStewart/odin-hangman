# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/words'
require_relative 'lib/printer'

def save(game)
  saved_game = Marshal.dump game
  Dir.mkdir 'saves' unless Dir.exist? 'saves'
  File.open('saves/game.hangman', 'w') { |file| file.puts saved_game }
end

def load(file_name)
  serialized_game = File.open file_name, 'r'  
  Marshal.load serialized_game
end

def print_main_menu
  puts "\n" * 50
  puts "Welcome to Hangman!\n\n_____Options_____\n/n - New Game\n/l - Load Game\n/x - Exit\nEnter selection:"
end

def play_game(game)
  printer = Printer.new game
  playing = true
  while playing
    printer.print
    input = gets.chomp.downcase

    word_is_guessed = game.guess input

    playing = false if input == '/m' || game.strikes_left.zero? || word_is_guessed
    save game if input == '/s'
  end
  printer.print_end_game word_is_guessed unless input == '/x'
end

def play_new_game
  secret_word = Words.random_word
  game = Game.new secret_word
  play_game game
end

exited = false
until exited
  print_main_menu
  input = gets.chomp.downcase

  case input
  when '/n' 
    play_new_game
  when '/l'
    game = load 'saves/game.hangman'
    play_game game
  when '/x'
    exited = true 
  end
end

