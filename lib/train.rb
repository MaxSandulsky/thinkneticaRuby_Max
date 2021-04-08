class Train
  attr_reader :speed, :vagons, :number, :type, :route
  
  def initialize(number, type, vagons)
    @number, @type, @vagons = number, type, vagons
  end

  def vagons_increase
    if @speed == 0
      @vagons += 1
    end
  end
  
  def vagons_decrease
    if @speed == 0
      @vagons -= 1
    end
  end
  
  def speed_gain(velocity)
    @speed += velocity
  end
  
  def stop
    @speed = 0
  end
  
  def train_route=(route_set)
    @route = route_set
    route.first.arriving_train(self)
    @current_station_index = 0
  end

  def move_forward
    if  next_station != nil
      current_station.departure_train(self)
      @current_station_index += 1
      current_station.arriving_train(self)
    end
  end
  
  def move_backward
    if  passed_station != nil
      current_station.departure_train(self)
      @current_station_index -= 1
      current_station.arriving_train(self)
    end
  end
  
  def current_station
    route.stations[@current_station_index]
  end
  
  def passed_station
    route.stations[@current_station_index - 1]
  end
  
  def next_station
    route.stations[@current_station_index + 1]
  end
  
end