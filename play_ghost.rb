require_relative "ghost"
require_relative "player" 

class Play_ghost
    # manual player instantiation implementation
    # play = Ghost.new(  Player.new("Person 1"), Player.new("Person 2"), )
    
    if __FILE__ == $PROGRAM_NAME
        puts "Number of players: "
        num_players = gets.chomp.to_i
        players = []

        # create an array of Player objects
        (1..num_players).each do |i|
            puts "Enter Name for Player #{i}:" 
            players << Player.new("#{gets.chomp}") 
        end

        play = Ghost.new( players )   
        play.populate_dict()
        play.play_round() 
    end

end # end of Play_ghost class
