 module Pressman

  class InvalidMove < StandardError
  end

  class Board < Array

    def initialize 
      super(8)
      b = self.each_with_index.map do |row, i| 
        case i
        when 0,1
          Array.new(8, :white)
        when 6,7
          Array.new(8, :black)
        else
          Array.new(8)
        end
      end
      self.replace(b)
    end

    # board.move(:user => @black, :src => [1,0], :dst => [2,0])
    def move(opts)
      raise InvalidMove unless MoveValidation.valid?(opts.merge(:board => self))
      sx, sy = opts[:src]
      dx, dy = opts[:dst]
      self[dx][dy] = self[sx][sy]
      self[sx][sy] = nil
    end

    def valid_move?(sx,sy,dx,dy)
      !self[sx][sy].nil? && 
      [sx,sy] != [dx,dy] &&
      self[sx][sy] != self[dx][dy] &&
      ((sx - dx).abs == (sy - dy).abs || sx == dx || sy == dy) 
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