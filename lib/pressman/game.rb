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
        current, opponent = players

        move = current.get_move # player gives move coordinates or resigns
        
        if current.resigned?
          @winner = opponent
          break 
        end

        Move.new(move.merge(:player => current, :board => @board)).execute

        if @board.empty_square_in_home_row?(current) && 
          active_stone = @board.active_stone_in_opponents_home_row(current) &&
          current.generate?

          active_stone.deactivate
          coords = @board.empty_squares_in(current.home_row)
          generate_stone(:player => current, :dst => coords)
        end
        
        @winner = current unless @board.pieces?(opponent)
        players.reverse!
      end
      announce_winner
    end

    def generate_stone(opts)
      x,y = opts[:dst]
      color = opts[:player].color
      @board[x][y] = Stone.new(color)  
    end

    def announce_winner
      raise NotImplementedError
    end

  end

end