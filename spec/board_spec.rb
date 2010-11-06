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