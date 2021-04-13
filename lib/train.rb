class Train
  attr_reader :route, :wagons, :current_station_index
  attr_accessor :speed, :number
  
  def initialize(number)
    self.wagons = []
    self.number = number
    self.speed = 0
  end

  def wagon_connect(wagon)
    self.wagons << wagon if self.speed.zero? && !self.wagons.include?(wagon)
  end

  def wagon_disconnect(wagon)
    self.wagons.delete(wagon) if self.speed.zero? && self.wagons.include?(wagon)
  end

  def speed_gain(velocity)
    @speed += velocity
  end

  def stop
    @speed = 0
  end

  def train_route=(route_set)
    @route = route_set
    self.current_station_index = 0
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
    route.stations[@current_station_index] unless current_station_index.nil?
  end

  def passed_station
    route.stations[@current_station_index - 1] unless current_station_index.nil?
  end

  def next_station
    route.stations[@current_station_index + 1] unless current_station_index.nil?
  end

  private # Понятие "индекс текущей станции" не существует в контексте реальности и является абстрактным выражением "текущая станция"

  attr_writer :current_station_index, :wagons
end
