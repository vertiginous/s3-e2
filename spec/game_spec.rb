describe Pressman::Game do
  before do
    @game = Pressman::Game.new
  end

  # it "should have a board"
  # it "should have two players"
  # it "should start with the black player"
  # it "should end if one player captures all of the other player's stones"
  # it "should end if one player resigns"

  it "should generate a new stone if necesary" do
    @game.board[1][0] = nil
    @game.board[0][0] = nil
    @game.board[7][0] = nil
    Pressman::Move.new(:player => @game.black, :src => [6,0], :dst => [0,0], :board => @game.board).execute
    @game.generate(@game.black)
    @game.board[0][0].should_not be_active
    @game.board[7][0].should_not be_nil
  end

end
