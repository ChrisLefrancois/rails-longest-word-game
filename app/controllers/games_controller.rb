require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = generate_grid
  end

  def score
    @attempt = params[:attempt]
    @grid = params[:grid]
    @response = ""

    @attempt.split('').each do |letter|
      if @grid.include?(letter.upcase) && check_word?(@attempt)
        @response = "Congratulation!, #{@attempt.upcase} is an english valid word"
      elsif @grid.include?(letter.upcase)
        @response = "#{@attempt.upcase} does not seem to be an english word"
      else
        @response = 'not a valid word'
      end
    end
  end

  private

  def generate_grid
    alphabet = ('A'..'Z').to_a
    # TODO: generate random grid of letters
    i = 0
    grid = []
    while i < rand(4..10)
      grid << alphabet.sample
      i += 1
    end
    grid
  end

  def check_word?(word)
    # TODO: runs the game and return detailed hash of result (with `:score`, `:message` and `:time` keys)

    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
