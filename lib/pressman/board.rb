 module Pressman

  class Board < Array

    def initialize 
      super(8)
      b = self.each_with_index.map do |row, i| 
        case i
        when WHITE_FIRST_ROW, WHITE_SECOND_ROW
          Array.new(8){ Stone.new(:white) }
        when BLACK_FIRST_ROW, BLACK_SECOND_ROW
          Array.new(8){ Stone.new(:black) }
        else
          Array.new(8)
        end
      end
      self.replace(b)
    end

    def pieces?(player)
      self.any? do |row| 
        row.any?{|s| s.is_a?(Stone) && s.color == player.color }
      end
    end

    def empty_square_in_home_row?(player)
      self[player.home_row].any?{|s| s.nil? }
    end

    def active_stone_in_opponents_home_row(player)
      self[player.opposite_home_row].find{|s| s.is_a?(Stone) && s.color == player.color && s.active? }
    end

    def empty_squares_in(row)
      self[row].select{|i| i.nil?}.count
    end

  end

end