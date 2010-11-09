describe Pressman::Game do
  before do
    @game = Pressman::Game.new
    @board = @game.instance_variable_get(:@board)
    @black = @game.instance_variable_get(:@black)
    @white = @game.instance_variable_get(:@white)
    @black.stub!(:generate?).and_return(true)
    @black.stub!(:choose_square).and_return{|i| i.first }
  end

  # it "should have a board"
  # it "should have two players"
  # it "should start with the black player"
  # it "should end if one player captures all of the other player's stones"
  # it "should end if one player resigns"

  it "should generate a new stone if necesary" do
    @board[1][0] = nil
    @board[0][0] = nil
    @board[7][0] = nil
    Pressman::Move.new(:player => @black, :src => [6,0], :dst => [0,0], :board => @board).execute
    @game.generate(@black)
    @board[0][0].should_not be_active
    @board[7][0].should_not be_nil
  end

end
