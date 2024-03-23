require 'yaml'

module Serializer
    @@serializer = YAML

    def serialize
        Dir.mkdir('saved_games') unless Dir.exist?('saved_games')

        file = File.open('saved_games/saves.yaml', 'w') do |f|
            @@serializer.dump(self, f)
        end
        file.close
        exit
    end

    def deserialize
        File.open('saved_games/saves.yaml', 'r') do |f|
            loaded_game = @@serializer.load(f)
            loaded_game.guess
        end
    end
end