require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    letters = []
    10.times do
      letters << ('a'..'z').to_a.sample(1)
    end
    @letters = letters.flatten
  end

  def include?
    # array = []
    sum = 0
    splited_word = params[:word].split('')
    params[:letters].split.each do |letter|
      # until splited_word.empty?
      if splited_word.include?(letter)
        # array.push(letter)
         index = splited_word.find_index(letter)
         splited_word.delete_at(index)
      end
    end
    splited_word.empty? ? true : false
  end

  def score
    if include?
      url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
      serialized = open(url).read
      dictionary = JSON.parse(serialized)
      if dictionary['found'] == true
        @score = "Congratulations! #{params[:word]} is a valid English word!"
      else
        @score = "Sorry but #{params[:word]} does not seem to be a valid English word.."
      end
    else
      @score = "Sorry but #{params[:word]} can't be buil out of"
    end
  end
end
