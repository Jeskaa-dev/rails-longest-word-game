require 'open-uri'

class WordsController < ApplicationController
  VOWELS = %w(A E I O U Y)
  def shuffle
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @letterscombi = params[:letters]
    url = "https://dictionary.lewagon.com/#{params[:input].upcase}"
    @wordtest = JSON.parse(URI.parse(url).read)["found"]

    @includingtest = params[:letters].split.each {|letter| params[:letters].include?(letter.upcase)}

    if !@includingtest
      @message = "Sorry but #{params[:input].upcase} can't be built out of #{params[:letters]}"
      @score = 0
    elsif !@wordtest
      @message = "Sorry but #{params[:input].upcase} does not seem to be a valid English word..."
      @score = 0
    else
      @score = params[:input].length
      @message = @score >= 5 ? 'Well done' : 'Can do better'
    end
  end
end
