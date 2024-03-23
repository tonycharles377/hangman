require_relative 'serializer'

class Hangman
    #mixin
    include Serializer

    @@words = File.readlines('google-10000-english-no-swears.txt').map!(&:chomp)

    def initialize
        @number_of_guesses = 0
        @word = rand_word(@@words)
        @list_of_char_guessed = []
        @display = @word.split('').map{|char| char = '_'}
    end

    def guess
        @number_of_guesses += 1
        @lives_remaining = 14 - @number_of_guesses
        puts "You have #{@lives_remaining} live(s) remaining!\nGuess a letter"
        @char = gets.chomp
        @list_of_char_guessed << @char  
    end

    def display_correct_guess
        if !game_over?
            guess()
            @word.split('').each_with_index do |ichar, i|
                if ichar == @char.downcase
                    @display[i] = ichar
                end
            end
            p @display.join(' ')

            puts "Do you want to save and exit game? Y/N"
            if gets.chomp == "y"
                save_game
            end

            if @word.split('') == @display
                puts "You win!"
            else
                display_correct_guess()
            end
        else
            puts "Game over! You are out of lives!"
            puts "The correct word is '#{@word}'"
        end
    end

    def game_over?
        @number_of_guesses > 13
    end

    #game loop
    def play
        puts "Welcome to hangman game!"

        if saved_games?
            puts "Would you like to load a saved game? Y/N"
            if gets.chomp == 'y'
                load_game
            else
                display_correct_guess
            end
        end
    end

    def save_game
        serialize
    end

    def load_game
        deserialize
    end

    def saved_games?
        Dir.exist?('saved_games') && Dir.entries('saved_games').length >= 1
    end

    private

    def rand_word(words)
        word = words.sample

        if word.length >= 5 && word.length <= 12
            word
        else
            rand_word(words)
        end
    end
        
end

testing = Hangman.new
testing.play