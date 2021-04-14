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
    trains.delete(train) if trains.include?(train)
  end

  def get_sorted_list(sortby)
    trains_count = trains.select { |train| train.class == sortby }
    trains_count.length
  end
end
