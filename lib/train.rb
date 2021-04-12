class Train
  attr_reader :speed, :number, :route, :wagons, :current_station_index

  def initialize(number)
    @wagons = []
    @number = number
    @speed = 0
  end

  def wagon_connect(wagon)
    wagon.connect(self) if speed.zero? && !wagons.include?(wagon)
    puts "That wagon now connected to the train: #{wagons.include?(wagon)}"
  end

  def wagon_disconnect(wagon)
    wagon.disconnect(self) if speed.zero? && wagons.include?(wagon)
    puts wagons.include?(wagon).to_s
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

  attr_writer :current_station_index
end
