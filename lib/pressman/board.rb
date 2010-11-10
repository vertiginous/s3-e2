 module Pressman

  class Board
    extend Forwardable

    def initialize 
      @b = Array.new(8).each_with_index.map do |row, i| 
        case i
        when WHITE_FIRST_ROW, WHITE_SECOND_ROW
          Array.new(8){ Stone.new(:white) }
        when BLACK_FIRST_ROW, BLACK_SECOND_ROW
          Array.new(8){ Stone.new(:black) }
        else
          Array.new(8)
        end
      end
    end

    def_delegator :@b, :[]
    def_delegator :@b, :[]=
    def_delegator :@b, :any?
    def_delegator :@b, :clear
    def_delegator :@b, :size
    def_delegator :@b, :each

    def pieces?(player)
      any? do |row| 
        row.any?{|s| s.is_a?(Stone) && s.color == player.color }
      end
    end

    def empty_square_in_home_row?(player)
      self[player.home_row].any?{|s| s.nil? }
    end

    def active_stone_in_opponents_home_row(player)
      self[player.opposite_home_row].find do |s| 
        s.is_a?(Stone) && s.color == player.color && s.active?
      end
    end

    def empty_squares_in(row)
      self[row].each_with_index.map{|s, i| i if s.nil?}.compact
    end

  end

end