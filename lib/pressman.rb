
module Pressman

  BLACK_FIRST_ROW  = 7
  BLACK_SECOND_ROW = 6
  WHITE_FIRST_ROW  = 0
  WHITE_SECOND_ROW = 1

  BLACK_SIDE       = (4..7)
  WHITE_SIDE       = (0..3)

end

require 'forwardable'

require 'pressman/game'
require 'pressman/board'
require 'pressman/player'
require 'pressman/move'
require 'pressman/stone'
