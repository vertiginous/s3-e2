describe Pressman::Player do
  before do
    @player1 = Pressman::Player.new(:black)
  end

  it "should have a color" do
    @player1.color.should == :black
    @player1.color.should_not == :white
  end

  it "should have 16 stones"
  it "should be able to move stones"
  it "should capture opponents stones when moving into a square occupied by the opponent's stone"

  it "should be allowed to resign" do 
    @player1.should_not be_resigned
    @player1.resign
    @player1.should be_resigned
  end
end