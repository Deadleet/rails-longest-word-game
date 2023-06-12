class GamesController < ApplicationController

 require "open-uri"
  def new
    @alphabet = [*('A'..'Z')]
    @letters = @alphabet.sample(10)

  end

  def score
    # @message = "vrai"
    @word = params[:word]
    @letters = params[:letters]

    sum = 0
    @word_array = @word.chars #transforme en array
    @word_array.each do |letter|
      if @word_array.count(letter) > @letters.count(letter)
        sum += 1
      end
    end
      if sum > 0
        @message = "Tu n'as pas respecté la consigne. Les lettres utilisé dans ton mot ne correspondent pas à la proposition"
      else
      # faire un action
        run_game(@word)
      end
  end
end

#attention programme pas fini
def run_game(attempt)
  # TODO: runs the game and return detailed hash of result
  url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
  word_info = URI.open(url).read
  @word = JSON.parse(word_info)

  if @word["found"] == false
    @message = "Désolé, le mot n'existe pas en anglais"
  else
    @message = "Super, tu as respecté la consigne et le mot existe. Victoire"
  end
end
