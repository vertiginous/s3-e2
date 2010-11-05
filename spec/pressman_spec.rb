# describe Pressman do

  describe Pressman::Game do
    it "should have a board"
    it "should have two players"
    it "should not allow invalid moves"
    it "should start with the black player"
    it "should end when on player captures all of the other player's stones"
  end

  describe Pressman::Board do
    
    before do
      @board = Pressman::Board.new
    end

    it "should be an 8 x 8 grid" do
      @board.size.should == 8
      @board.each{|r| r.size.should == 8 }
    end

    it "should start with 16 white pieces in the top two rows" do
      @board[0].each{|i| i.should == :white }
      @board[1].each{|i| i.should == :white }
    end

    it "should start with 16 black pieces in the bottom two rows" do
      @board[6].each{|i| i.should == :black }
      @board[7].each{|i| i.should == :black }
    end

    it "should move the pieces" do
      @board.move([1,0], [4,0])
      @board[4][0].should == :white
      @board[1][0].should be_nil
    end

    it "should not allow invalid moves" do
      lambda{ @board.move([1,0], [1,0]) }.should raise_exception( Pressman::InvalidMove )
      lambda{ @board.move([5,0], [5,0]) }.should raise_exception( Pressman::InvalidMove )
      lambda{ @board.move([1,0], [1,1]) }.should raise_exception( Pressman::InvalidMove )
      lambda{ @board.move([6,0], [5,3]) }.should raise_exception( Pressman::InvalidMove )
    end

   # A stone may only move into a square if no other stone occupies any of the squares between the stone’s current square and its destination square.

   # A stone may not move into a square occupied by another stone of the same colour.

   # A stone may move up, down, left, right, or diagonally within the grid and along any number of free squares, but only one direction per turn.

  end

  describe Pressman::Player do
    it "should have a color"
    it "should have 16 stones"
    it "should be able to move stones"
    it "should capture opponents stones when moving into a square occupied by the opponent's stone"
    it "should be allowed to resign"
  end

# end