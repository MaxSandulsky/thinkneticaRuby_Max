class Train
  attr_reader :speed, :number, :route, :wagons, :current_station_index

  def initialize(number)
    @wagons = []
    @number = number
    @speed = 0
  end

  def wagon_connect(wagon)
    wagon.connect(self) if self.speed.zero? && !self.wagons.include?(wagon)
    puts "#{self.wagons.include?(wagon)}"
  end

  def wagon_disconnect(wagon)
    wagon.disconnect(self) if self.speed.zero? && self.wagons.include?(wagon)
    puts "#{self.wagons.include?(wagon)}"
  end

  def speed_gain(velocity)
    @speed += velocity
  end

  def stop
    @speed = 0
  end

  def train_route=(route_set)
    @route = route_set
    @current_station_index = 0
    current_station.arriving_train(self)
  end

  def move_forward
    unless next_station.nil?
      current_station.departure_train(self)
      @current_station_index += 1
      current_station.arriving_train(self)
    end
  end

  def move_backward
    unless passed_station.nil?
      current_station.departure_train(self)
      @current_station_index -= 1
      current_station.arriving_train(self)
    end
  end

  def current_station
    unless current_station_index.nil?
      route.stations[@current_station_index]
    end
  end

  def passed_station
    unless current_station_index.nil?
      route.stations[@current_station_index - 1]
    end
  end

  def next_station
    unless current_station_index.nil?
      route.stations[@current_station_index + 1]
    end
  end
  private
  def current_station_index=(index)
    @current_station_index = index
  end
  
end
