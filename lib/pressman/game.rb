 module Pressman
  
  class Game

    attr_reader :winner

    def initialize
      @board = Board.new
      @black = Player.new(:black)
      @white = Player.new(:white)
      @winner = nil
    end

    def play
      players = [@black, @white]
      until @winner
        @current, @opponent = players 
        Move.new(@current.get_move.merge(:player => @current, :board => @board)).execute

        #generate

        @winner = @opponent if current.resigned?
        @winner = @current  unless @board.pieces?(@opponent)
        players.reverse!
      end
    end

    # def generate
    #   if @board.empty_square_in_home_row?(@current) && active_stone = @board.active_stone_in_opponents_home_row(@current)
    #     x,y = active_stone
    #     @board[x][y].deactivate if 
    #   end
    # end

  end

end