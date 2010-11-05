 module Pressman
  
  class Game

    def initialize
      @board = Board.new
      @black = Player.new(:black)
      @white = Player.new(:white)
    end

  end

end