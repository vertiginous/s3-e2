  describe Pressman::Move do
    
    def new_move(opts)
      Pressman::Move.new(opts)
    end

    before do
      @board  = Pressman::Board.new

      @p1     = Pressman::Player.new(:black)
      @move   = new_move(:player => @p1, :board => @board)

      @p2     = Pressman::Player.new(:white)
      @move2  = new_move(:player => @p2, :board => @board)
    end
    
    it "should move the pieces" do
      move = new_move(:src => [6,7], :dst => [3,4], :player => @p1, :board => @board)
      move.execute
      @board[3][4].color.should == :black
      @board[6][7].should be_nil

      move2 = new_move(:src => [1,0], :dst => [4,0], :player => @p2, :board => @board)
      move2.execute
      @board[4][0].color.should == :white
      @board[1][0].should be_nil
    end

    it "should not allow invalid moves" do
      move = new_move(:src => [1,0], :dst => [4,0], :player => @p1, :board => @board)
      lambda{ move.execute }.should raise_exception( Pressman::ImproperOwner )

      move = new_move(:src => [5,0], :dst => [4,0], :player => @p1, :board => @board)
      lambda{ move.execute }.should raise_exception( Pressman::EmptySource )
      
      move = new_move(:src => [1,0], :dst => [1,0], :player => @p2, :board => @board)
      lambda{ move.execute }.should raise_exception( Pressman::NotAnActualMove )
      
      move = new_move(:src => [1,0], :dst => [1,1], :player => @p2, :board => @board)
      lambda{ move.execute }.should raise_exception( Pressman::CantLandOnSelf )
      
      move = new_move(:src => [6,0], :dst => [5,3], :player => @p1, :board => @board)
      lambda{ move.execute }.should raise_exception( Pressman::InvalidDirection )
      
      new_move(:src => [6,2], :dst => [5,2], :player => @p1, :board => @board).execute
      move = new_move(:src => [6,0], :dst => [6,2], :player => @p1, :board => @board)
      lambda{ move.execute }.should raise_exception( Pressman::PathBlocked ) # horizontal path blocked
      
      move = new_move(:src => [7,0], :dst => [5,0], :player => @p1, :board => @board)
      lambda{ move.execute }.should raise_exception( Pressman::PathBlocked ) # vertical path blocked
      
      move = new_move(:src => [7,0], :dst => [4,3], :player => @p1, :board => @board)
      lambda{ move.execute }.should raise_exception( Pressman::PathBlocked ) # diagonal path blocked
    end

    it "should check if generation is allowed"
    it "should deactivate the piece after generation"
    it "should activate the piece when it crosses back accross the centerline"

    it "should not allow a move when there is nothing in the source square" do
      @move.sx = 1
      @move.sy = 0
      @move.src_not_nil?.should be_true

      @move.sx = 3
      @move.sy = 0
      @move.src_not_nil?.should be_false
    end

    it "should not allow a move when the moving player doesn't own the stone" do
      @move.sx = 6
      @move.sy = 0
      @move.proper_owner?.should be_true

      @move.sx = 1
      @move.sy = 0
      @move.proper_owner?.should be_false
    end      

    it "should now allow a move to the same square" do
      @move.sx = 6
      @move.sy = 0
      @move.dx = 5
      @move.dy = 0
      @move.actual_move?.should be_true

      @move.sx = 1
      @move.sy = 0
      @move.dx = 1
      @move.dy = 0
      @move.actual_move?.should be_false
    end

    it "should not allow a move into a square occupied by another stone of the same colour" do
      @move.sx = 6
      @move.sy = 0
      @move.dx = 5
      @move.dy = 1
      @move.not_landing_on_self?.should be_true

      @move.sx = 1
      @move.sy = 0
      @move.dx = 1
      @move.dy = 1
      @move.not_landing_on_self?.should be_false
    end

    it "should recognize vertical moves" do
      @move.sx = 6
      @move.sy = 0
      @move.dx = 5
      @move.dy = 0
      @move.vertical?.should be_true

      @move.sx = 1
      @move.sy = 0
      @move.dx = 1
      @move.dy = 1
      @move.vertical?.should be_false
    end

    it "should recognize horizontal moves" do
      @move.sx = 1
      @move.sy = 0
      @move.dx = 1
      @move.dy = 1
      @move.horizontal?.should be_true
      
      @move.sx = 6
      @move.sy = 0
      @move.dx = 5
      @move.dy = 0
      @move.horizontal?.should be_false
    end

    it "should recognize diagonal moves" do
      @move.sx = 6
      @move.sy = 0
      @move.dx = 4
      @move.dy = 2
      @move.diagonal?.should be_true
      
      @move.sx = 1
      @move.sy = 0
      @move.dx = 1
      @move.dy = 1
      @move.diagonal?.should be_false
      
      @move.sx = 6
      @move.sy = 7
      @move.dx = 4
      @move.dy = 5
      @move.diagonal?.should be_true
      
      @move.sx = 1
      @move.sy = 0
      @move.dx = 2
      @move.dy = 0
      @move.diagonal?.should be_false
    end

   # A stone may only move into a square if no other stone occupies any of the squares between the stone’s current square and its destination square.
   it "should check for stones in the path of the move" do 
      @move.sx = 0
      @move.sy = 0
      @move.dx = 0
      @move.dy = 2
      @move.path_free?.should be_false
      
      @move.sx = 7
      @move.sy = 7
      @move.dx = 4
      @move.dy = 4
      @move.path_free?.should be_false
   end

  end