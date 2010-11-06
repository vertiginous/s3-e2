$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))
require 'rubygems'
require 'term/ansicolor'

class String
  include Term::ANSIColor
end

module Pressman

  BLACK_FIRST_ROW  = 7
  BLACK_SECOND_ROW = 6
  WHITE_FIRST_ROW  = 0
  WHITE_SECOND_ROW = 1

end

require 'pressman/game'
require 'pressman/board'
require 'pressman/player'
require 'pressman/move'
