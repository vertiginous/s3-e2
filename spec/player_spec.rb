describe Pressman::Player do
  before do
    @player1 = Pressman::Player.new(:black)
  end

  it "should have a color" do
    @player1.color.should == :black
    @player1.color.should_not == :white
  end

  it "should be allowed to resign" do 
    @player1.should_not be_resigned
    @player1.resign
    @player1.should be_resigned
  end

  it "should have a home row" do
    @player1.home_row.should == Pressman::BLACK_FIRST_ROW
    @player1.opposite_home_row.should == Pressman::WHITE_FIRST_ROW
  end

  it "should have a side" do
    @player1.side.should == Pressman::BLACK_SIDE
  end
end