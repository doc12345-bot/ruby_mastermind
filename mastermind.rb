
require 'pry-byebug'
require 'colorize'

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
            end
        end

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


class MastermindLogic
    
    def initialize
        @secret_code = generate_code
    end

    def tell_secret
        @secret_code
    end

    def generate_code
        code = Array.new(4) {rand(1...7)}
        code
    end

    def correct_guess?(guess)
        guess == @secret_code
    end

    def give_feedback(guess)
        feedback = Array.new(0)

        puts "This is the secret: #{@secret_code}"

        clone_code = @secret_code.to_a.map(&:clone)

        exact = exact_match(clone_code, guess)
        nearly = wrong_place(clone_code, guess)
        #puts "Matches #{exact}"
        #puts "Near misses #{nearly}"

        exact.times do
            feedback << "#"
        end

        nearly.times do
            feedback << "0"
        end

        #Compares a clone of the secret code with the guess and, if there is a match, alters the 
        #clone. 
        #guess.each_with_index do |color, index|
        #    if clone_code.include?(guess[index]) && clone_code[index] != guess[index]
        #        feedback << "0"
        #        position = clone_code.find_index(guess[index])
        #        clone_code[position] = nil
        #    elsif clone_code[index] == guess[index]
        #        puts "This is the code at index #{index} here: #{clone_code[index]}"
        #        puts "This is the guess at index #{index} here: #{guess[index]}"
        #        feedback << "#"
        #        clone_code[index] = nil  
        #   else
        #        feedback << "_"
        #    end
        #end
        #feedback = bubble_sort(feedback.join)

        puts feedback.join
    end

    #Checks to see if the code and guess have any exact matches.
    def exact_match(code, guess)
        matches = 0

        code.each_with_index do |colour, index|
            next unless colour == guess[index]

            matches +=1
            code[index] = "#"
            guess[index] = "#"
        end
        #Returns int
        matches
    end

    #Checks to see the secret code contains the guess.
    def wrong_place(code, guess)
        matches = 0

        guess.each_index do |index|
            #Skips unless code includes guess and they are not at the same index.
            next unless guess[index] != "#" && code.include?(guess[index]) && code[index] != guess[index]

            matches +=1

            #Finds the index of matching number then removes.
            found = code.find_index(guess[index])
            code[found] = "0"
            guess[index] = "0"
        end
        matches
    end

    #Defunct now that feedback method is fixed
    def bubble_sort(array)
        #Generic bubble sort method
        length = array.length
        sorted = Array.new(length)

        loop do
            swapped = false

            #Goes over the array, pushing the higher numbers up the chain
            (length-1).times do |i|
                if array[i] > array[i+1]
                    array[i], array[i+1] = array[i+1], array[i]
                    swapped = true
                end
            end

            break if not swapped
        end
        array
    end
end

#Separate the I/O from the logic, eventually, which will go here. 
class MastermindIO
    COLORS_STRING = ["red", "green", "blue", "yellow", "cyan", "magenta"].freeze
    COLORS = {
        1 => :red,
        2 => :green,
        3 => :blue,
        4 => :yellow,
        5 => :cyan,
        6 => :magenta,
        "#" => :grey,
        "0" => :light_white
      }.freeze
      
    MAX_GUESSES = 2
    CODE_LENGTH = 4

    def initialize
        @game_logic = MastermindLogic.new
        @guesses = 0
    end

    def play
        # Put some info about the game
        puts "Welcome to Mastermind!"
        puts "The code is #{CODE_LENGTH} colours long and you have #{MAX_GUESSES} guesses."
        puts "The code consists of these colours #{COLORS_STRING}." 
        puts "Enter the index of the colour from 1 to #{COLORS_STRING.length}. Good luck!"
        puts ""
        
        # loop till guesses == max
        while @guesses < MAX_GUESSES
            #guess = get_guess
            guess = get_guess   
              
            @guesses += 1

            # guess is correct? congratulate
            if @game_logic.correct_guess?(guess)
                puts "Congratulations! Your guess was correct!"
                puts "You win!"
                puts ""
                break
            else
            # not, feedback
                puts "Sorry, not quite right. Here's a few pointers."
                puts ""
                puts "The # means your guess was correct and in the right position."
                puts "The 0 means the colour was correct but in the wrong position."
                puts "This feedback does not represent the order of your guess."
                puts ""
                #puts @game_logic.tell_secret

                puts "Guesses remaining #{MAX_GUESSES - @guesses}"

                @game_logic.give_feedback(guess)
            end
        end
        code_in_colour = other_background(convert_to_colour(@game_logic.tell_secret))
        puts code_in_colour.class
        puts "This was the secret code: #{code_in_colour}."
        puts "This was the secret code: #{convert_to_colour(@game_logic.tell_secret).join(" ")}."
        puts " "
        puts "Thank you for playing!"
    end

    def get_guess
        valid = false
        while valid == false
            puts "Try to break the code. Type your guess below (as a number):"
            guess = gets.chomp

            #Splits to four digit array, but still as string. Map iterates and converts.
            guess = guess.chars.map(&:to_i)

            guess.each_with_index do | element, index |
                #puts "This #{element} and this index: #{index}"
            end
            
            #Check input is valid (four digits, lower than 7)
            if guess.length == 4 && guess.all? {|digit| digit.between?(1, 6)}
                valid = true
            else
                puts "Try again using only four digits lower than 7."
            end
        end
        string_colour_guess = convert_to_colour(guess)
        puts "This is the guess, colorized: #{other_background(string_colour_guess)}"
        puts "This is the guess, colorized: #{background(guess)}"
        guess
    end

    #Colours the background of each number
    def background(array)
        new_guess = Array.new(4)
        array.each_with_index do |x, index|
          new_guess[index] = x.to_s.colorize(:background => COLORS[x])
        end
        new_guess.join
    end

    #This converts strings into the appropriate coloured background
    #Not quite working
    def other_background(array)
        new_guess = Array.new(4)
        array.each_with_index do |x, index|
          new_guess[index] = x.to_s.colorize(:background => COLORS[index+1])
        end
        new_guess.join
    end
      
    #Converts to word from COLORS
    def convert_to_colour(array)
        x = 0
        new_guess = Array.new(4)
        #Converts numbers to corresponding colour
        while x < CODE_LENGTH do
            new_guess[x] = COLORS_STRING[array[x]-1]
            x += 1
        end
        return new_guess
    end

end

#puts " Testing ".white.on_red

#puts " Testing ".colorize(:background => :light_white)


gameOne = MastermindIO.new()
gameOne.play