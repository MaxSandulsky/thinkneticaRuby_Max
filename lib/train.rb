class Train
  attr_reader :speed, :vagons, :number, :type, :stations
  
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
  
  def train_route=(route)
    @stations = Stations.new(route.first, nil, route.stations[1], 0, route.stations)
    route.first.arriving_train(self)
  end

  def move_forward
    if  stations.next_station != nil
      stations.current_station.departure_train(self)
      stations.current_station_index += 1
      move
      stations.current_station.arriving_train(self)
    end
  end
  
  def move_backward
    if  stations.passed_station != nil
      stations.current_station.departure_train(self)
      stations.current_station_index -= 1
      move
      stations.current_station.arriving_train(self)
    end
  end

  def move
      stations.passed_station = stations.route[stations.current_station_index - 1]
      stations.current_station = stations.route[stations.current_station_index]
      stations.next_station = stations.route[stations.current_station_index + 1]
  end
  
  Stations = Struct.new(:current_station, :passed_station, :next_station, :current_station_index, :route)
  
end