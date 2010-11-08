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

        # player gives move coordinates or resigns
        coordinatess = current.get_move 
        @winner = opponent and break if current.resigned?

        move(coordinatess)
        generate(current) 

        @winner = current unless @board.pieces?(opponent)
        players.reverse!
      end
      announce_winner
    end

    def generate(player)
      active_stone = @board.active_stone_in_opponents_home_row(current)
      if @board.empty_square_in_home_row?(current) && 
        active_stone && current.generate?

        active_stone.deactivate
        x,y = @board.empty_squares_in(current.home_row)
        @board[x][y] = Stone.new(player.color)  
      end
    end      

    def move(opts)
      Move.new(move.merge(:player => current, :board => @board)).execute
    end

    def announce_winner
      raise NotImplementedError
    end

  end

end