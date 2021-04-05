class Station
  attr_accessor :title
  def initialize(title = "not Exist")
    @trains_on_board = []
    @title = title
  end
  def arrivingTrain=(train)
    @trains_on_board << train
  end
end
