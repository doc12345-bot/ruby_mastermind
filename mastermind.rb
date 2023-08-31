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
    def generate_code
        #generate random four digit code using numbers one to six.
        #Numbers represent colours.
        #Allow, or don't duplicates depending on user request.
        code = Array.new(4) {rand(1...7)}
        code[0] = rand(1...7)
        if duplicates == false
            for x in code[x] do
            code[x] = rand(1...7)
            if code[x]

        #Need to restrict this for duplicate numbers, or not, depending on the users answer.
        if duplicates == false
        end
    end
end

#code breaker class
class Codebreaker
    def initialize
        @guesses
    end

    def update_guesses
        @guesses - 1
        puts "You have #{@guesses} left."
    end
end

class Game

end


class Mastermind
    COLORS = ["red", "green", "blue", "yellow", "purple", "orange"].freeze
    MAX_GUESSES = 12
    CODE_LENGTH = 4
    
    def initialize
        guesses = 0
        @secret_code = generate_code

    end

    def play
        # Put some info about the game
        puts "Welcome to Mastermind!"
        puts "The code is #{CODE_LENGTH} colours long and you have #{MAX_GUESSES}."
        puts "The code consists of these colours #{COLORS.merge}." 
        puts "Enter the index of the colour from 0 to #{COLORS.length - 1}. Good luck!"
        # while loop till guesses == max
        while guesses != MAX_GUESSES
            #guess = get_guess
            guess = get_guess.map do |color_index_string|
                color_index_string.to_i
              end
              
            guesses += 1

            # if guess is correct, congratulate
            if correct_guess?
                puts "Congratulations! Your guess was correct!"
            else
            # if not, feedback
                guess.give_feedback
            end
    end

    private
    def generate_code
        code = Array.new(4) {rand(1...7)}
    end

    def get_guess
        puts "Try to break the code. Type your guess below (as a number):"
        guess = gets.chomp.split
        x = 0
        #Converts numbers to corresponding colour
        while x < CODE_LENGTH do
            new_guess[x] = COLORS[guess[x]]
            puts new_guess[x]
        end
    end

    def correct_guess?(guess)
        guess == code
    end

    def give_feedback(guess)
        feedback  = Array.new(4)
        #Check for same colour
        guess.each_with_index do |color, index|
            if code[index] == color
                feedback << "O"
            elsif code.include?(color)
                feedback << "0"
            else
                feedback << "X"
            end
        end
        feedback
        #Check for index
        #Return answer in an array, O for correct guess and place, 0 for colour but wrong place and X for nothing.
    end

    def bubble_sort(array)
        #Generic bubble sort method, UNFINISHED
        length = arrary.length
        sorted = Array.new(4)


    end



end
newCode = Codemaker.new
newCode.generate_code