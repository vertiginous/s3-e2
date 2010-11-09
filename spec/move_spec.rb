  describe Pressman::Move do
    
    def new_move(opts)
      Pressman::Move.new(opts)
    end

    before do
      @board  = Pressman::Board.new
      @black     = Pressman::Player.new(:black)
      @white     = Pressman::Player.new(:white)
    end
    
    it "should move the pieces" do
      move = new_move(:src => [6,7], :dst => [3,4], :player => @black, :board => @board)
      move.execute
      @board[3][4].color.should == :black
      @board[6][7].should be_nil

      move2 = new_move(:src => [1,0], :dst => [4,0], :player => @white, :board => @board)
      move2.execute
      @board[4][0].color.should == :white
      @board[1][0].should be_nil
    end

    it "should not allow invalid moves" do
      move = new_move(:src => [1,0], :dst => [4,0], :player => @black, :board => @board)
      lambda{ move.execute }.should raise_exception( Pressman::ImproperOwner )

      move = new_move(:src => [5,0], :dst => [4,0], :player => @black, :board => @board)
      lambda{ move.execute }.should raise_exception( Pressman::EmptySource )
      
      move = new_move(:src => [1,0], :dst => [1,0], :player => @white, :board => @board)
      lambda{ move.execute }.should raise_exception( Pressman::NotAnActualMove )
      
      move = new_move(:src => [1,0], :dst => [1,1], :player => @white, :board => @board)
      lambda{ move.execute }.should raise_exception( Pressman::CantLandOnSelf )
      
      move = new_move(:src => [6,0], :dst => [5,3], :player => @black, :board => @board)
      lambda{ move.execute }.should raise_exception( Pressman::InvalidDirection )
      
      new_move(:src => [6,2], :dst => [5,2], :player => @black, :board => @board).execute
      move = new_move(:src => [6,0], :dst => [6,2], :player => @black, :board => @board)
      lambda{ move.execute }.should raise_exception( Pressman::PathBlocked ) # horizontal path blocked
      
      move = new_move(:src => [7,0], :dst => [5,0], :player => @black, :board => @board)
      lambda{ move.execute }.should raise_exception( Pressman::PathBlocked ) # vertical path blocked
      
      move = new_move(:src => [7,0], :dst => [4,3], :player => @black, :board => @board)
      lambda{ move.execute }.should raise_exception( Pressman::PathBlocked ) # diagonal path blocked
    end

    it "should not allow a move when there is nothing in the source square" do
      move = new_move(:src => [1,0], :dst => [4,0], :player => @black, :board => @board)
      move.src_not_nil?.should be_true

      move = new_move(:src => [3,0], :dst => [4,0], :player => @black, :board => @board)
      move.src_not_nil?.should be_false
    end

    it "should not allow a move when the moving player doesn't own the stone" do
      move = new_move(:src => [6,0], :dst => [4,0], :player => @black, :board => @board)
      move.proper_owner?.should be_true

      move = new_move(:src => [1,0], :dst => [4,0], :player => @black, :board => @board)
      move.proper_owner?.should be_false
    end      

    it "should now allow a move to the same square" do
      move = new_move(:src => [6,0], :dst => [5,0], :player => @black, :board => @board)
      move.actual_move?.should be_true

      move = new_move(:src => [1,0], :dst => [1,0], :player => @black, :board => @board)
      move.actual_move?.should be_false
    end

    it "should not allow a move into a square occupied by another stone of the same colour" do
      move = new_move(:src => [6,0], :dst => [5,1], :player => @black, :board => @board)
      move.not_landing_on_self?.should be_true

      move = new_move(:src => [1,0], :dst => [1,1], :player => @black, :board => @board)
      move.not_landing_on_self?.should be_false
    end

    it "should recognize vertical moves" do
      move = new_move(:src => [6,0], :dst => [5,0], :player => @black, :board => @board)
      move.vertical?.should be_true

      move = new_move(:src => [1,0], :dst => [1,1], :player => @black, :board => @board)
      move.vertical?.should be_false
    end

    it "should recognize horizontal moves" do
      move = new_move(:src => [1,0], :dst => [1,1], :player => @black, :board => @board)
      move.horizontal?.should be_true
      
      move = new_move(:src => [6,0], :dst => [5,0], :player => @black, :board => @board)
      move.horizontal?.should be_false
    end

    it "should recognize diagonal moves" do
      move = new_move(:src => [6,0], :dst => [4,2], :player => @black, :board => @board)
      move.diagonal?.should be_true
      
      move = new_move(:src => [1,0], :dst => [1,1], :player => @black, :board => @board)
      move.diagonal?.should be_false
      
      move = new_move(:src => [6,7], :dst => [4,5], :player => @black, :board => @board)
      move.diagonal?.should be_true
      
      move = new_move(:src => [1,0], :dst => [2,0], :player => @black, :board => @board)
      move.diagonal?.should be_false
    end

   # A stone may only move into a square if no other stone occupies any of the squares between the stone’s current square and its destination square.
   it "should check for stones in the path of the move" do 
      move = new_move(:src => [0,0], :dst => [0,2], :player => @black, :board => @board)
      move.path_free?.should be_false

      move = new_move(:src => [7,7], :dst => [4,4], :player => @p1, :board => @board)
      move.path_free?.should be_false
   end

   describe "activate?" do
    it "should check the move to see if it qualifies the stone for reactivation" do
      @board[0][0] = Pressman::Stone.new(:black)
      move = new_move(:src => [0,0], :dst => [4,0], :player => @black, :board => @board)
      move.activate?.should be_true

      @board[0][0] = Pressman::Stone.new(:black)
      move = new_move(:src => [0,0], :dst => [3,0], :player => @black, :board => @board)
      move.activate?.should be_false
    end
   end

   it "should activate the stone if it needs to be" do
      stone = Pressman::Stone.new(:black)
      stone.deactivate
      @board[0][0] = stone
      @board[1][0] = nil

      move = new_move(:src => [0,0], :dst => [4,0], :player => @black, :board => @board)
      move.execute
      @board[4][0].should eql stone
      @board[4][0].should be_active
    end

  end