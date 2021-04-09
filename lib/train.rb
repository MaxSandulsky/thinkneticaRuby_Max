class Train
  attr_reader :speed, :wagons, :number, :type, :route

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
  end

  def wagons_increase
    @wagons += 1 if @speed == 0
  end

  def wagons_decrease
    @wagons -= 1 if @speed == 0
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
      # если мы стоим на первой станции, то passed_station = nil
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
