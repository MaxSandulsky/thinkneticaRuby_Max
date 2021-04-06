class Station
  attr_reader :title
  def initialize(title)
    @trains = []
    @title = title
  end
  
  def arrivingtrain(train)
    @trains << train 
  end
  
  def trains
    @trains.each { |train| puts "Train: #{train.number} on st: #{@title}" }
  end
  
  def departuretrain(train) 
    @trains.delete(train)
  end
  
  def getsortedlist(sortby)
    @trains.select { |train| train.type == sortby}
  end
end