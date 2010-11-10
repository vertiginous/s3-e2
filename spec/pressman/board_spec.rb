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

      it "should be true if the player still has stones on the board" do
        @board.pieces?(@black).should be_true
        @board.pieces?(@white).should be_true
      end

      it "should be false if the player doesn't have any stones on the board" do
        @board.clear
        @board.pieces?(@black).should be_false
        @board.pieces?(@white).should be_false
      end

    end

    describe "empty_square_in_home_row?" do
      it "should be true if there's an empty square in the player's home row" do
        @board.empty_square_in_home_row?(@black).should be_false
        @board[7][0] = nil
        @board.empty_square_in_home_row?(@black).should be_true
      end
    end

    describe "active_stone_in_opponents_home_row" do

      it "should return an active stone in the opponent's home row" do  
        @stone = Pressman::Stone.new(:black)
        @board[0][0] = @stone
        @board.active_stone_in_opponents_home_row(@black).should eql @stone
      end

      it "should be nil otherwise" do
        @board.active_stone_in_opponents_home_row(@black).should be_nil
      end
    end

    describe "empty_squares_in" do
      it "should return the count of empty squares in a given row" do
        @board.empty_squares_in(7).should == []
        @board[7][0] = nil
        @board.empty_squares_in(7).should == [0]
      end
    end

  end