  describe Pressman::Board do
    
    before do
      @board = Pressman::Board.new
      @black = Pressman::Player.new(:black)
      @white = Pressman::Player.new(:white)
    end

    it "should be an 8 x 8 grid" do
      @board.size.should == 8
      @board.each{|r| r.size.should == 8 }
    end

    it "should start with 16 white pieces in the top two rows" do
      @board[0].each{|i| i.color.should == :white }
      @board[1].each{|i| i.color.should == :white }
      @board[0][0].should_not eql @board[0][1]
    end

    it "should start with 16 black pieces in the bottom two rows" do
      @board[6].each{|i| i.color.should == :black }
      @board[7].each{|i| i.color.should == :black }
      @board[7][0].should_not eql @board[7][1]
    end

    describe "pieces?" do

      it "should return true if the given player still has stones on the board" do
        @board.pieces?(@black).should be_true
        @board.pieces?(@white).should be_true
      end

      it "should return false if the given player doesn't have any stones on the board" do
        @board.clear
        @board.pieces?(@black).should be_false
        @board.pieces?(@white).should be_false
      end

    end

    describe "empty_square_in_home_row?" do
      it "should return true if there is an empty square in the given player's home row" do
        @board.empty_square_in_home_row?(@black).should be_false
        @board[7][0] = nil
        @board.empty_square_in_home_row?(@black).should be_true
      end
    end

    describe "active_stone_in_opponents_home_row" do
      it "should return coordinates of an active stone in the given player's opponent's home row, or nil" do
        @board.active_stone_in_opponents_home_row?(@black).should be_nil
        @board[0][0] = Pressman::Stone.new(:black)
        @board.active_stone_in_opponents_home_row?(@black).should == [0,0]
      end
    end

      

  end