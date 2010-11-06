 module Pressman

  class Board < Array

    def initialize 
      super(8)
      b = self.each_with_index.map do |row, i| 
        case i
        when WHITE_FIRST_ROW, WHITE_SECOND_ROW
          Array.new(8, :white)
        when BLACK_FIRST_ROW, BLACK_SECOND_ROW
          Array.new(8, :black)
        else
          Array.new(8)
        end
      end
      self.replace(b)
    end

    PIECES = {
      :black => '| # ',
      :white => '|' + ' # '.yellow.bold,
      nil    => '|   '
    }

    def to_s
      nl      = "\n"
      line    = ('-' * 33) + nl
      end_row = "|#{nl}#{line}"
      line + map{|row| row.map{|c| PIECES[c] }.join + end_row }.join
    end

  end

end