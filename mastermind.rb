#Board class
class Board
    def initialize
        @board
        @guesses
        @duplicates
    end
#Create board
    #prompt for number of guesses
    def number_of_guesses
        puts "Welcome! How many guesses do you want to have? It must be an even number."
        @guesses = gets.chomp
        #Check if number is even and is a number
    
        #prompt for allowance of duplicates
        puts "Do you want to allow for duplicate colours? Please type yes or no."
        duplicate = gets.chomp
        while duplicate != "yes" || "no"
            puts "Please type yes or no if you want duplicates."
            duplicate == gets.chomp 
        end
    
        if duplicate == "yes"
            @duplicates = true
        elsif duplicate == "no"
            @duplicates = false
        end

    end

#display board
def rule_display 
   puts "How to play Mastermind:"
   puts "/n"
   puts "This is a single player game again the computer."
   puts "You, the player, must break the computers code."
   puts "There are six different number combinations:"
   puts "/n"
   puts "1 2 3 4 5 6" 
   puts "/n"
   puts "The computer will create a sequence of four, the master code. For example:"
   puts "/n"
   puts "3215"
   puts "/n"
   puts "If you have chosen to allow duplicates, then the code may contain them."
   puts "You will have the same number of guesses that you entered earlier."
   puts "/n"
   puts "Clues:"
   puts "After each guess, there will be clues to help you break the code."
   puts "/n"
   puts "O This means one of your guesses was correct AND in the correct place."
   puts "+ This means that one of your guesses was correct but in the wrong position."
   puts "If there are no clues, your guess was incorrect."
   puts "/n"
   puts "Example:"
   puts "Using the above master code, this guess would receive these clues:"
   puts "/n"
   puts "1234  O++"
   puts "/n"
   puts "The guess had one correct number in the correct location and two correct numbers in the wrong location."
   puts "/n"
   puts "Ok, lets play!"
end

#countdown of turns

#compare guess to code
    #give feedback
end

#code maker class
class Codemaker
    #

end

#code breaker class
class Codebreaker

end