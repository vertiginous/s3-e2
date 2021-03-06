describe Pressman::Stone do
  before do
    @stone = Pressman::Stone.new(:black)
  end

  it "should have a color" do
    @stone.color.should == :black
  end

  it "should start off activated" do
    @stone.should be_active
  end

  describe "equality" do
    it "should determine equality by stone color" do
      black = Pressman::Stone.new(:black)
      white = Pressman::Stone.new(:white)
      @stone.should == black
      @stone.should_not == white
    end
  end

  describe "deactivate" do
    it "should mark the stone inactive" do
      @stone.deactivate
      @stone.should_not be_active
    end
  end


  describe "activate" do
    it "should mark the stone active" do
      @stone.deactivate
      @stone.should_not be_active
      @stone.activate
      @stone.should be_active
    end
  end

end