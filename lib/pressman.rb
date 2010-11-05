$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))
require 'rubygems'
require 'term/ansicolor'

class String
  include Term::ANSIColor
end

require 'pressman/game'
require 'pressman/board'
require 'pressman/player'
require 'pressman/move_validation'
