require_relative 'prodaction_company.rb'
require_relative 'instance_counter.rb'

class Train
  include ProdactionCompany
  include InstanceCounter

  attr_reader :route, :wagons, :current_station_index
  attr_accessor :speed

  def initialize(number, prodaction_company)
    self.prodaction_company = prodaction_company
    self.number = number
    self.wagons = []
    self.speed = 0
    
    register_instance
  end

  def wagon_connect(wagon)
    return nil unless speed.zero?
    return nil if wagon.nil?
    return nil unless type.eql?(wagon.type)
    self.wagons << wagon
  end

  def wagon_disconnect(wagon)
    return nil unless speed.zero?
    return nil if wagon.nil?
    wagons.delete(wagon)
  end

  def speed_gain(velocity)
    @speed += velocity
  end

  def stop
    @speed = 0
  end

  def train_route=(route_set)
    return nil if route_set.nil?
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
