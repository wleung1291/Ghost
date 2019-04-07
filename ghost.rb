require_relative "player"

class Ghost

    def initialize(players) # *players if manual player instantiation
        @fragment = ""
        @dictionary = Hash.new(0) # Use hash for faster lookup than an array
        @players = players
        @losses = Hash.new(0)
        @ghost = Hash.new(0)
        @players.each { |player| @losses[player] = 0 }
        @players.each { |player| @ghost[player] = "" }
    end

    attr_reader :dictionary, :fragment

    # Populate dictionary hash with words from dictionary.txt
    def populate_dict()
        File.readlines("dictionary.txt").each_with_index do |line, line_num|
           @dictionary[line_num] = line.chomp
        end
        return @dictionary
    end
    
    def play_round
        puts "----------GHOST GAME----------"
        print_score()
        puts
        @fragment = ""

        until @dictionary.include?(@fragment)
            take_turn()
            next_player!()
        end
    end

    def take_turn()
        input = current_player().guess
        valid_play?(input)
    end

    def game_over?
        if @ghost[current_player()] == "GHOST"
            puts "#{current_player().name} has lost the game!"
            puts
            puts "--FINAL SCORE--"
            print_score()
            puts "---------------"
            return true
        end

        return false
    end

    # Called when the fragment is invalid or a complete word
    def round_over
        puts
        puts "#{current_player().name} lost the round!"
        puts
        update_score()

        if game_over?()
           abort
        end
        
        next_player!()
        play_round()
    end
    
    # Check if the next guess makes fragment a valid word before changing it
    def valid_play?(str)
        alpha = ("a".."z").to_a

        if alpha.include?(str)
            tempStr = @fragment + str
            if @fragment.length < 3 #Populate the fragment with 3 chars then check
                @fragment += str
                p @fragment
            else
                @dictionary.values.each do |word|
                    # checks if the string is a valid substring of a word
                    if word.start_with?(tempStr) #if word[0...tempStr.length].include?(tempStr)
                        @fragment += str
                        p @fragment
                        # checks if the fragment is a valid word
                        if @dictionary.values.include?(@fragment)
                            round_over()
                        end
                        return @fragment                        
                    end
                end
                puts
                print "#{@fragment += str} is not a valid word." 
                round_over()
            end
            return @fragment
        else 
            puts 
            puts "Invalid guess, try again."  
            puts 
            take_turn()
        end
    end

    # The current player
    def current_player
        @players.first
    end
    
    # rotate the players to take turns guessing
    def next_player!
        @players.rotate!
    end

    def print_score
        @ghost.each do |player, score|
            puts "#{player.name} : #{score}"
        end
    end

    def update_score
        @losses[self.current_player] += 1
            
        case @losses[self.current_player] 
        when 1 
            @ghost[self.current_player] += "G"
        when 2
            @ghost[self.current_player] += "H"
        when 3 
            @ghost[self.current_player] += "O"
        when 4 
            @ghost[self.current_player] += "S"
        when 5 
            @ghost[self.current_player] += "T"  
        end
    end

end     # end of Ghost class
