class Station
  attr_reader :title, :trains
  def initialize(title)
    @trains = []
    @title = title
  end
  
  def arriving_train(train)
    @trains << train 
  end
  
  def departure_train(train) 
    if trains.include?(train)
      trains.delete(train)
    end
  end
  
  def get_sorted_list(sortby)
    trains.select { |train| train.type == sortby}
  end
end