class Hangman

    @@words = File.readlines('google-10000-english-no-swears.txt').map!(&:chomp)

    attr_accessor :human, :computer, :word

    def initialize
        @human = "player1"
        @computer = "player2"
        @word = rand_word(@@words)

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
puts testing.word

