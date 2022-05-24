require "json"
require "open-uri"

class GamesController < ApplicationController
  def play
    @letters = ('a'..'z').to_a
    # @letter_array = []
    @sample = @letters.sample(10)
  end

  def score
    # The word can’t be built out of the original grid
    # get the users guess
    @users_guess = params[:users_guess]
    # get the list of letters given
    @game_tiles = params[:game_tiles]
    # see if the users guess is different from the list of letters given
    # iterate through the users guess for letters and match it to the list of letters
    @users_guess_characters = @users_guess.split('')
    @users_guess_characters.each do |character|
      if @game_tiles.include?(character)

        # The word is valid according to the grid, but is not a valid English word
        @file = URI.open("https://wagon-dictionary.herokuapp.com/#{@users_guess}")
        # html_doc = Nokogiri::JSON(html_file)
        @json_file = JSON.parse(@file.read)
        @validation = @json_file['found']
        if @validation == true
          @response = "#{@users_guess} is a real word"
        else
          @response = "#{@users_guess} is not a real word"
        end
      else
        # word with wrong tiles
        @response = "#{@users_guess} can't be built out of #{@game_tiles}"
      end
    end
  end
end
