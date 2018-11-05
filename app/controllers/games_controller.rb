class GamesController < ApplicationController
  require 'open-uri'
  require 'nokogiri'
  require 'json'


  LETTERS = []
  UNCHANGED = []
  def new
    LETTERS.clear
    UNCHANGED.clear
    @letters = []
    1.upto(10) { alphabet = ('a'..'z').to_a.sample
      @letters << alphabet
      LETTERS << alphabet
      UNCHANGED << alphabet}
  end

  def score
    @correct = false
    @english = false
    @guessed = params[:guess]
    filtered = []
    @letters = UNCHANGED
    url = "https://wagon-dictionary.herokuapp.com/#{@guessed}"
    html_file = JSON.parse(open(url).read)
    if  html_file["found"] == true
      @english = true
      @guessed.split("").each_with_index do |char, index|
        if LETTERS.include?(char)
          filtered << char
          LETTERS.slice!(LETTERS.index(char))
        end
      end
      if filtered.length == @guessed.length
        @correct = true
      end
    end
  end
end
