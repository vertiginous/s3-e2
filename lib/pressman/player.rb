 module Pressman
  
  class Player

    attr_reader :color
    def initialize(color)
      @color    = color
      @resigned = nil
    end

    def resign
      @resigned = true
    end

    def resigned?
      @resigned
    end

    def home_row
      @color == :white ? WHITE_FIRST_ROW : BLACK_FIRST_ROW
    end

    def opposite_home_row
      @color == :white ? BLACK_FIRST_ROW : WHITE_FIRST_ROW
    end

    # user interface NOT IMPLEMENTED

    # should return source and destination coordinates
    # in a hash, or nil if the player resigns
    # {:src => [x,y]. :dst => [x2,y2]}
    def get_move
      raise NotImplementedError
    end

    # should prompt the user and return true 
    #  if the user wants to generate a new stone
    def generate?
      raise NotImplementedError
    end

  end

end