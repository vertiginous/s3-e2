module Pressman

  InvalidMove = Class.new(StandardError)

  EmptySource      = Class.new(InvalidMove)
  ImproperOwner    = Class.new(InvalidMove)
  NotAnActualMove  = Class.new(InvalidMove)
  CantLandOnSelf   = Class.new(InvalidMove)
  InvalidDirection = Class.new(InvalidMove)
  PathBlocked      = Class.new(InvalidMove)

  class Move

    def self.execute(opts)
      new(opts).execute
    end

    attr_accessor :sx, :sy, :dx, :dy

    def initialize(opts)
      @sx, @sy = opts[:src]
      @dx, @dy = opts[:dst]
      @board   = opts[:board]
      @player  = opts[:player]
    end

    # move.execute(:user => @black, :src => [1,0], :dst => [2,0], :board => @board)
    def execute
      validate
      r = @board[@dx][@dy] = @board[@sx][@sy]
      @board[@sx][@sy] = nil
      r.activate if activate?
      r
    end

    def validate
      raise EmptySource      unless src_not_nil?
      raise ImproperOwner    unless proper_owner? 
      raise NotAnActualMove  unless actual_move? 
      raise CantLandOnSelf   unless not_landing_on_self? 
      raise InvalidDirection unless valid_path? 
      raise PathBlocked      unless path_free?
    end

    def src_not_nil?
      !@board[@sx][@sy].nil?
    end

    def proper_owner?
      @board[@sx][@sy].color == @player.color
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

    def activate?
      @sx == @player.opposite_home_row && @player.side.include?(@dx)
    end

    # helper methods

    def path
      case true
      when horizontal?
        y_points.map{|y| @board[@sx][y] }
      when vertical?
        x_points.map{|x| @board[x][@sy] }
      when diagonal?
        x_points.zip(y_points).map{|x,y| @board[x][y] }
      end
    end

    def x_points
      points_from(@sx,@dx)
    end

    def y_points
      points_from(@sy,@dy)
    end

    def points_from(s,d)
      s.send((s < d ? :upto : :downto), d).map{|i| i }[1..-2]
    end

  end

end