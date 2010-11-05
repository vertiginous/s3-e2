module Pressman

  class InvalidMove < StandardError
  end

  class EmptySource < InvalidMove
  end

  class ImproperOwner < InvalidMove
  end

  class NotAnActualMove < InvalidMove
  end

  class CantLandOnSelf < InvalidMove
  end

  class InvalidDirection < InvalidMove
  end

  class PathBlocked < InvalidMove
  end

  class MoveValidation

    def self.validate(opts)
      new(opts).validate
    end

    attr_accessor :sx, :sy, :dx, :dy

    def initialize(opts)
      @sx, @sy = opts[:src]
      @dx, @dy = opts[:dst]
      @board   = opts[:board]
      @player  = opts[:player]
    end

    def validate
      raise EmptySource      unless src_not_nil?
      raise ImproperOwner    unless proper_owner? 
      raise NotAnActualMove  unless actual_move? 
      raise CantLandOnSelf   unless not_landing_on_self? 
      raise InvalidDirection unless  valid_path? 
      raise PathBlocked      unless path_free?
    end

    def src_not_nil?
      !@board[@sx][@sy].nil?
    end

    def proper_owner?
      @board[@sx][@sy] == @player.color
    end

    def actual_move?
       [@sx,@sy] != [@dx,@dy] 
    end

    def not_landing_on_self?
       @board[@sx][@sy] != @board[@dx][@dy]
    end

    def valid_path?
      (vertical? || horizontal? || diagonal?) 
    end

    def horizontal?
      @sx == @dx
    end

    def vertical?
      @sy == @dy
    end

    def diagonal?
      (@sx - @dx).abs == (@sy - @dy).abs
    end

    def path_free?
      path.none?
    end

    # helper methods

    def path
      case true
      when horizontal?
        y_axis.map{|y| @board[@sx][y] }
      when vertical?
        x_axis.map{|x| @board[x][@sy] }
      when diagonal?
        x_axis.zip(y_axis).map{|x,y| @board[x][y] }
      end
    end

    def x_axis
      cells(@sx,@dx)
    end

    def y_axis
      cells(@sy,@dy)
    end

    def cells(s,d)
      s.send((s < d ? :upto : :downto), d).map{|i| i }[1..-2]
    end

  end

end