class Train
  attr_reader :speed, :vagons, :number, :type, :current_station, :passed_station, :next_station
  
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
    @train_route = route.stations
    @current_station = route.first
    @next_station = route.stations[1]
    @current_station_index = 0
  end

  def move_forward
    if  @next_station != nil
      @train_route[@current_station_index].departure_train(self)
      @passed_station = @current_station
      @current_station = @next_station
      @current_station_index += 1
      @next_station = @train_route[@current_station_index]
      @train_route[@current_station_index].arriving_train(self)
    end
  end
  
  def move_backward
    if  @passed_station != nil
      @train_route[@current_station_index].departure_train(self)
      @next_station = @current_station
      @current_station = @passed_station
      @current_station_index -= 1
      @passed_station = @train_route[@current_station_index]
      @train_route[@current_station_index].arriving_train(self)
    end
  end

end