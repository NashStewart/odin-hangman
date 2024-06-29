# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/words'
require_relative 'lib/printer'

def save(game)
  save_name = ''
  while save_name.empty?
    puts "\n" * 50
    puts 'Enter save name:'
    save_name = gets.chomp
  end
  serialized_game = Marshal.dump game
  Dir.mkdir 'saves' unless Dir.exist? 'saves'
  File.open("saves/#{save_name}.hangman", 'w') { |file| file.puts serialized_game }
end

def print_load_menu(saves)
  puts "\n" * 50
  puts 'Select a load file by entering number:'
  saves.each_with_index { |save, index| puts "#{index + 1} - #{save.gsub('.hangman', '')}" }
end

def load(_file_name)
  saves = Dir.entries 'saves'
  saves.select! { |save| save.include? '.hangman' }
  file_key = 0
  while file_key.zero?
    print_load_menu saves
    file_key = gets.chomp.to_i
    file_key = 0 unless file_key.between?(1, saves.length)
  end
  serialized_game = File.open "saves/#{saves[file_key - 1]}", 'r'
  # Disabled rubocop here, because this app isn't exposed to the web. So there isn't any risk.
  Marshal.load serialized_game # rubocop:disable Security/MarshalLoad
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
  printer.print_end_game word_is_guessed unless input == '/m'
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
