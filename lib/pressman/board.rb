 module Pressman

  class Board < Array

    def initialize 
      super(8)
      b = self.each_with_index.map do |row, i| 
        case i
        when WHITE_FIRST_ROW, WHITE_SECOND_ROW
          Array.new(8, Stone.new(:white))
        when BLACK_FIRST_ROW, BLACK_SECOND_ROW
          Array.new(8, Stone.new(:black))
        else
          Array.new(8)
        end
      end
      self.replace(b)
    end

    def pieces?(player)
      self.any? do |row| 
        row.any?{|square| square.color == player.color rescue nil }
      end
    end

  end

end