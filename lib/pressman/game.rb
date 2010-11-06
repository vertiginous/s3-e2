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
        player, opponent = players 
        player.make_a_move
        # generate if generate?
        @winner = opponent if player.resigned?
        @winner = player   unless @board.pieces?(opponent)
        players.reverse!
      end
    end

    # def generate
    #   @board[@dx][@dy]
    # end

    # def generate?
    #   move_is_to_opposite_home_row? && empty_spot_in_home_row? && piece_is_active?
    # end

    # def move_is_to_opposite_home_row?
    #   @player.opposite_home_row == @dx
    # end

    # def empty_spot_in_home_row?
    #   !@board[@player.home_row].all?
    # end

    # def piece_is_active?
    #   @board[@dx][@dy].active?
    # end
  end

end