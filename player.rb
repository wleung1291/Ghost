
class Player 

    def initialize(name)
        @name = name
    end

    attr_reader :name

    def guess
        print "Enter your guess, #{@name}: "
        input = gets.chomp
        return input
    end

end # end of Player class