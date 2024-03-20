class Hangman
    @@number_of_gueses = 0
    @@words = File.readlines('google-10000-english-no-swears.txt').map!(&:chomp)

    attr_accessor :human, :computer

    def initialize
        @human = "player1"
        @computer = "player2"
        @word = rand_word(@@words)
        @@display = @word.split('').map{|char| char = '_'}
    end

    

    def guess
        @@number_of_gueses += 1
        puts "You have #{15 - @@number_of_gueses} live(s) remaining!\nGuess a letter"
        @char = gets.chomp
    end

    def display_correct_guess

        if !game_over?
            guess()
            @word.split('').each_with_index do |ichar, i|
                if ichar == @char
                    @@display[i] = ichar
                end
            end
            p @@display.join(' ')

            if @word.split('') == @@display
                puts "You win!"
            else
                display_correct_guess()
            end
        else
            puts "Game over! You are out of lives!"
        end
    end

    def game_over?
        @@number_of_gueses > 13
    end

    #game loop
    def play
        display_correct_guess
    end

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

