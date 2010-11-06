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

  end

end