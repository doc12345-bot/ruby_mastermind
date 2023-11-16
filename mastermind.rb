# frozen_string_literal: true

require 'pry-byebug'
require 'colorize'

# Game logic
class MastermindLogic
  def initialize
    @secret_code = generate_code
  end

  def tell_secret
    @secret_code
  end

  def generate_code
    code = Array.new(4) { rand(1...7) }
  end

  def correct_guess?(guess)
    guess == @secret_code
  end

  def give_feedback(guess)
    feedback = Array.new(0)
    clone_code = @secret_code.to_a.map(&:clone)
    exact = exact_match(clone_code, guess)
    nearly = wrong_place(clone_code, guess)
    exact.times { feedback << '#' }
    nearly.times { feedback << '0' }
    puts feedback.join
  end

  # Checks to see if the code and guess have any exact matches.
  def exact_match(code, guess)
    matches = 0
    code.each_with_index do |colour, index|
      next unless colour == guess[index]

      matches += 1
      code[index] = '#'
      guess[index] = '#'
    end
    # Returns int
    matches
  end

  # Checks to see the secret code contains the guess.
  def wrong_place(code, guess)
    matches = 0
    # Skips unless code includes guess and they are not at the same index.
    guess.each_index do |index|
      next unless guess[index] != '#' && code.include?(guess[index]) && code[index] != guess[index]

      matches += 1

      # Finds the index of matching number then removes.
      found = code.find_index(guess[index])
      code[found] = '0'
      guess[index] = '0'
    end
    matches
  end
end

# Game
class MastermindIO
  COLORS_STRING = ['red', 'green', 'blue', 'yellow', 'cyan', 'magenta'].freeze
  COLORS = {
    1 => :red,
    2 => :green,
    3 => :blue,
    4 => :yellow,
    5 => :cyan,
    6 => :magenta,
    '#' => :grey,
    '0' => :light_white
  }.freeze

  MAX_GUESSES = 12
  CODE_LENGTH = 4

  def initialize
    @game_logic = MastermindLogic.new
    @guesses = 0
  end

  def play
    # Put some info about the game
    puts 'Welcome to Mastermind!'
    puts "The code is #{CODE_LENGTH} colours long and you have #{MAX_GUESSES} guesses."
    puts "The code consists of these colours #{COLORS_STRING}."
    puts "Enter the index of the colour from 1 to #{COLORS_STRING.length}. Good luck!"
    puts ''

    # loop till guesses == max
    while @guesses < MAX_GUESSES
        guess = get_guess
        @guesses += 1
        if @guesses == MAX_GUESSES
            break
        end

        # guess is correct? congratulate
        if @game_logic.correct_guess?(guess)
            puts 'Congratulations! Your guess was correct!'
            puts 'You win!'
            puts ''
            break
        else
        # not, feedback
            puts 'Sorry, not quite right. Here are a few pointers.'
            puts ''
            puts 'The # means your guess was correct and in the right position.'
            puts 'The 0 means the colour was correct but in the wrong position.'
            puts 'This feedback does not represent the order of your guess.'
            puts ''

            puts "Guesses remaining #{MAX_GUESSES - @guesses}"

            @game_logic.give_feedback(guess)
        end
     end
        code_in_colour = string_background(convert_to_colour_string(@game_logic.tell_secret))
        puts "This was the secret code: #{int_background(@game_logic.tell_secret)}."
        puts "This was the secret code: #{code_in_colour}."
        puts ''
        puts 'Thank you for playing!'
  end

  def get_guess
    valid = false
    while valid == false
        puts 'Try to break the code. Type your guess below (as a number):'
        guess = gets.chomp

        # Splits to four digit array, but still as string. Map iterates and converts.
        guess = guess.chars.map(&:to_i)

        # Check input is valid (four digits, lower than 7)
        if guess.length == 4 && guess.all? {|digit| digit.between?(1, 6)}
            valid = true
        else 
            puts 'Try again using only four digits lower than 7.'
        end
    end
    string_colour_guess = convert_to_colour_string(guess)
    puts "This is the guess, colorized: #{int_background(guess)}"
    puts "And in English: #{string_background(string_colour_guess)}"
    guess
end

  # Colours the background of each number
  def int_background(array)
    new_guess = Array.new(4)
    array.each_with_index do |x, index|
      new_guess[index] = x.to_s.colorize(:background => COLORS[x])
    end
    new_guess.join
    end

  # This converts strings into the appropriate coloured background
  def string_background(array)
    new_guess = Array.new(4)
    array.each_with_index do |x, index|
      new_guess[index] = x.colorize(:background => x.to_sym)
    end
    new_guess.join
  end

  # Converts to word from COLORS
  def convert_to_colour_string(array)
    x = 0
    new_guess = Array.new(4)
    # Converts numbers to corresponding colour
    while x < CODE_LENGTH do
      new_guess[x] = COLORS_STRING[array[x] - 1]
      x += 1
    end
    new_guess
    end
end

game_one = MastermindIO.new
game_one.play
