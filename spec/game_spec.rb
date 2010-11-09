describe Pressman::Game do
  before do
    @game = Pressman::Game.new
    @board = @game.instance_variable_get(:@board)
    @black = @game.instance_variable_get(:@black)
    @white = @game.instance_variable_get(:@white)
    @black.stub!(:generate?).and_return(true)
    @black.stub!(:choose_square).and_return{|i| i.first }
    @black.stub!(:get_move).and_return(:src => [6,0], :dst => [3,0])
    @white.stub!(:get_move).and_return(:src => [1,0], :dst => [2,0])
    @black.stub!(:announce_winner).and_return(true)
    @white.stub!(:announce_winner).and_return(true)
  end

  it "should end if one player captures all of the other player's stones" do

    @board[0] = Array.new(8)
    @board[1] = Array.new(8)
    @game.play
    @game.winner.should == @black
  end

  it "should end if one player resigns" do
    @white.resign
    @game.play
    @game.winner.should == @black
  end

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
