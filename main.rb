# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/words'
require_relative 'lib/printer'

def save(game, save_file: '')
  while save_file.empty?
    puts "\n" * 50
    puts 'Enter save name:'
    save_file = gets.chomp
  end
  serialized_game = Marshal.dump game
  Dir.mkdir 'saves' unless Dir.exist? 'saves'
  File.open("saves/#{save_file.split('.')[0]}.hangman", 'w') { |file| file.puts serialized_game }
end

def load(file_name)
  serialized_game = File.open "saves/#{file_name}", 'r'
  # Disabled rubocop here, because this app isn't exposed to the web. So there isn't any risk.
  Marshal.load serialized_game # rubocop:disable Security/MarshalLoad
end

def print_load_menu(saves)
  puts "\n" * 50
  puts 'Select a load file by entering number:'
  saves.each_with_index { |save, index| puts "#{index + 1} - #{save.gsub('.hangman', '')}" }
end

def no_saves_message
  puts "\n" * 50
  puts "No saved files\nPress ENTER to continue:"
  gets
  false
end

def saved_file_name
  saves = Dir.entries 'saves'
  saves.select! { |save| save.include? '.hangman' }
  return no_saves_message if saves.empty?

  file_key = 0
  while file_key.zero?
    print_load_menu saves
    file_key = gets.chomp.to_i
    file_key = 0 unless file_key.between?(1, saves.length)
  end
  saves[file_key - 1]
end

def print_main_menu
  puts "\n" * 50
  puts "Welcome to Hangman!\n\n_____Options_____\n/n - New Game\n/l - Load Game\n/x - Exit\nEnter selection:"
end

def game_over?(game, last_input, word_is_guessed)
  last_input == '/m' || game.strikes_left.zero? || word_is_guessed
end

def end_game(printer, word_is_guessed, save_file)
  printer.print_end_game word_is_guessed
  full_file_name = "saves/#{save_file}"
  File.delete(full_file_name) if File.exist? full_file_name
end

def play_game(game, save_file: '')
  printer = Printer.new game
  playing = true
  while playing
    printer.print
    input = gets.chomp.downcase
    word_is_guessed = game.guess input
    playing = false if game_over?(game, input, word_is_guessed)
    save_file.empty? ? (save(game) if input == '/s') : save(game, save_file: save_file)
  end
  end_game(printer, word_is_guessed, save_file) unless input == '/m'
end

def play_new_game
  secret_word = Words.random_word
  game = Game.new secret_word
  play_game game
end

exited = false
until exited
  print_main_menu
  case gets.chomp.downcase
  when '/n'
    play_new_game
  when '/l'
    file_name = saved_file_name
    next unless file_name

    game = load file_name
    play_game(game, save_file: file_name)
  when '/x'
    exited = true
  end
end
