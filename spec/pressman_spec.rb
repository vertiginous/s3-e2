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
      @p1    = Pressman::Player.new(:black)
      @p2    = Pressman::Player.new(:white)
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

  end

  describe Pressman::Player do
    before do
      @player1 = Pressman::Player.new(:black)
    end

    it "should have a color" do
      @player1.color.should == :black
      @player1.color.should_not == :white
    end

    it "should have 16 stones"
    it "should be able to move stones"
    it "should capture opponents stones when moving into a square occupied by the opponent's stone"
    it "should be allowed to resign"
  end

# end