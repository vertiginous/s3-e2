  describe Pressman::Move do
    
    def new_move(opts)
      Pressman::Move.new(opts)
    end

    before do
      @board  = Pressman::Board.new
      @black  = Pressman::Player.new(:black)
      @white  = Pressman::Player.new(:white)
      @black_move = {:player => @black, :board => @board}
      @white_move = {:player => @white, :board => @board}
    end
    
    it "should move the pieces" do
      move = new_move( @black_move.merge(:src => [6,7], :dst => [3,4]) )

      move.execute
      @board[3][4].color.should == :black
      @board[6][7].should be_nil

      move = new_move( @white_move.merge(:src => [1,0], :dst => [4,0]) )
      move.execute
      @board[4][0].color.should == :white
      @board[1][0].should be_nil
    end

    it "shouldn't allow invalid moves" do
      move = new_move(@black_move.merge(:src => [1,0], :dst => [4,0]))
      lambda{ move.execute }.should raise_exception( 
        Pressman::ImproperOwner 
      )

      move = new_move( @black_move.merge(:src => [5,0], :dst => [4,0]) )
      lambda{ move.execute }.should raise_exception( 
        Pressman::EmptySource 
      )
      
      move = new_move( @white_move.merge(:src => [1,0], :dst => [1,0]) )
      lambda{ move.execute }.should raise_exception( 
        Pressman::NotAnActualMove 
      )
      
      move = new_move( @white_move.merge(:src => [1,0], :dst => [1,1]) )
      lambda{ move.execute }.should raise_exception( 
        Pressman::CantLandOnSelf 
      )
      
      move = new_move( @black_move.merge(:src => [6,0], :dst => [5,3]) )
      lambda{ move.execute }.should raise_exception( 
        Pressman::InvalidDirection 
      )
      
      new_move( @black_move.merge(:src => [6,2], :dst => [5,2]) ).execute
      
      # horizontal path blocked
      move = new_move( @black_move.merge(:src => [6,0], :dst => [6,2]) )
      lambda{ move.execute }.should raise_exception( 
        Pressman::PathBlocked 
      )
      
      # vertical path blocked
      move = new_move( @black_move.merge(:src => [7,0], :dst => [5,0]) )
      lambda{ move.execute }.should raise_exception( 
        Pressman::PathBlocked 
      )
      
      # diagonal path blocked
      move = new_move( @black_move.merge(:src => [7,0], :dst => [4,3]) )
      lambda{ move.execute }.should raise_exception( 
        Pressman::PathBlocked 
      )
    end

    it "shouldn't allow a move when there is nothing in the source square" do
      move = new_move( @black_move.merge(:src => [1,0], :dst => [4,0]) )
      move.src_not_nil?.should be_true

      move = new_move( @black_move.merge(:src => [3,0], :dst => [4,0]) )
      move.src_not_nil?.should be_false
    end

    it "shouldn't allow a move when the moving player doesn't own the stone" do
      move = new_move( @black_move.merge(:src => [6,0], :dst => [4,0]) )
      move.proper_owner?.should be_true

      move = new_move( @black_move.merge(:src => [1,0], :dst => [4,0]) )
      move.proper_owner?.should be_false
    end      

    it "shouldn't allow a move to the same square" do
      move = new_move( @black_move.merge(:src => [6,0], :dst => [5,0]) )
      move.actual_move?.should be_true

      move = new_move( @black_move.merge(:src => [1,0], :dst => [1,0]) )
      move.actual_move?.should be_false
    end

    it "shouldn't allow moves to squares occupied by same-colored stones" do
      move = new_move( @black_move.merge(:src => [6,0], :dst => [5,1]) )
      move.not_landing_on_self?.should be_true

      move = new_move( @black_move.merge(:src => [1,0], :dst => [1,1]) )
      move.not_landing_on_self?.should be_false
    end

    it "should recognize vertical moves" do
      move = new_move( @black_move.merge(:src => [6,0], :dst => [5,0]) )
      move.vertical?.should be_true

      move = new_move( @black_move.merge(:src => [1,0], :dst => [1,1]) )
      move.vertical?.should be_false
    end

    it "should recognize horizontal moves" do
      move = new_move( @black_move.merge(:src => [1,0], :dst => [1,1]) )
      move.horizontal?.should be_true
      
      move = new_move( @black_move.merge(:src => [6,0], :dst => [5,0]) )
      move.horizontal?.should be_false
    end

    it "should recognize diagonal moves" do
      move = new_move( @black_move.merge(:src => [6,0], :dst => [4,2]) )
      move.diagonal?.should be_true
      
      move = new_move( @black_move.merge(:src => [1,0], :dst => [1,1]) )
      move.diagonal?.should be_false
      
      move = new_move( @black_move.merge(:src => [6,7], :dst => [4,5]) )
      move.diagonal?.should be_true
      
      move = new_move( @black_move.merge(:src => [1,0], :dst => [2,0]) )
      move.diagonal?.should be_false
    end

   it "should check for stones in the path of the move" do 
      move = new_move( @black_move.merge(:src => [0,0], :dst => [0,2]) )
      move.path_free?.should be_false

      move = new_move( @black_move.merge(:src => [7,7], :dst => [4,4]) )
      move.path_free?.should be_false
   end

   describe "activate?" do
    it "should check to see if the move allows the stone to be reactivated" do
      @board[0][0] = Pressman::Stone.new(:black)
      move = new_move( @black_move.merge(:src => [0,0], :dst => [4,0]) )
      move.activate?.should be_true

      @board[0][0] = Pressman::Stone.new(:black)
      move = new_move( @black_move.merge(:src => [0,0], :dst => [3,0]) )
      move.activate?.should be_false
    end
   end

   it "should activate the stone if it needs to be" do
      stone = Pressman::Stone.new(:black)
      stone.deactivate
      @board[0][0] = stone
      @board[1][0] = nil

      move = new_move( @black_move.merge(:src => [0,0], :dst => [4,0]) )
      move.execute
      @board[4][0].should eql stone
      @board[4][0].should be_active
    end

  end