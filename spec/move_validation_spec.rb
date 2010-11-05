  describe Pressman::MoveValidation do
    
    before do
      board  = Pressman::Board.new
      p1 = Pressman::Player.new(:black)
      @validation = Pressman::MoveValidation.new(:player => p1, :board => board)
    end

    it "should not allow a move when there is nothing in the source square" do
      @validation.sx = 1
      @validation.sy = 0
      @validation.src_not_nil?.should be_true

      @validation.sx = 3
      @validation.sy = 0
      @validation.src_not_nil?.should be_false
    end

    it "should not allow a move when the moving player doesn't own the stone" do
      @validation.sx = 6
      @validation.sy = 0
      @validation.proper_owner?.should be_true

      @validation.sx = 1
      @validation.sy = 0
      @validation.proper_owner?.should be_false
    end      

    it "should now allow a move to the same square" do
      @validation.sx = 6
      @validation.sy = 0
      @validation.dx = 5
      @validation.dy = 0
      @validation.actual_move?.should be_true

      @validation.sx = 1
      @validation.sy = 0
      @validation.dx = 1
      @validation.dy = 0
      @validation.actual_move?.should be_false
    end

    it "should not allow a move into a square occupied by another stone of the same colour" do
      @validation.sx = 6
      @validation.sy = 0
      @validation.dx = 5
      @validation.dy = 1
      @validation.not_landing_on_self?.should be_true

      @validation.sx = 1
      @validation.sy = 0
      @validation.dx = 1
      @validation.dy = 1
      @validation.not_landing_on_self?.should be_false
    end

    it "should recognize vertical moves" do
      @validation.sx = 6
      @validation.sy = 0
      @validation.dx = 5
      @validation.dy = 0
      @validation.vertical?.should be_true

      @validation.sx = 1
      @validation.sy = 0
      @validation.dx = 1
      @validation.dy = 1
      @validation.vertical?.should be_false
    end

    it "should recognize horizontal moves" do
      @validation.sx = 1
      @validation.sy = 0
      @validation.dx = 1
      @validation.dy = 1
      @validation.horizontal?.should be_true
      
      @validation.sx = 6
      @validation.sy = 0
      @validation.dx = 5
      @validation.dy = 0
      @validation.horizontal?.should be_false
    end

    it "should recognize diagonal moves" do
      @validation.sx = 6
      @validation.sy = 0
      @validation.dx = 4
      @validation.dy = 2
      @validation.diagonal?.should be_true
      
      @validation.sx = 1
      @validation.sy = 0
      @validation.dx = 1
      @validation.dy = 1
      @validation.diagonal?.should be_false
      
      @validation.sx = 6
      @validation.sy = 7
      @validation.dx = 4
      @validation.dy = 5
      @validation.diagonal?.should be_true
      
      @validation.sx = 1
      @validation.sy = 0
      @validation.dx = 2
      @validation.dy = 0
      @validation.diagonal?.should be_false
    end

   # A stone may only move into a square if no other stone occupies any of the squares between the stone’s current square and its destination square.
   it "should check for stones in the path of the move" 

  end