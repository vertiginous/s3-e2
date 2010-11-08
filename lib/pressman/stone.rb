 module Pressman

  class Stone

    attr_reader :color
    def initialize(color)
      @color  = color
      @active = true
    end

    def ==(other)
      return false if other.nil?
      self.color == other.color
    end

    def active?
      @active
    end

    def activate
      @active = true
    end

    def deactivate
      @active = false
    end

  end

end