require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'
require_relative 'train_validation.rb'

class Train
  include Manufacturer
  include InstanceCounter
  include TrainValidation
  
  attr_reader :wagons,  :route
  attr_accessor :speed
  
  def initialize(number, manufacturer)
    self.manufacturer = manufacturer
    self.number = number
    self.wagons = []
    self.speed = 0
    validation!
    register_instance
  end

  def wagon_connect(wagon)
    speed_validation!
    type_validation!(wagon)
    wagons << wagon
  end

  def wagon_disconnect(wagon)
    speed_validation!
    wagon_connection_validation!(wagon)
    wagons.delete(wagon)
  end

  def process_wagons(&block)
    wagons.each { |wagon| block.call(wagon) }
  end
  
  def speed_gain(velocity)
    @speed += velocity
  end

  def stop
    @speed = 0
  end

  def train_route=(route_set)
    self.route = route_set
    route_validation!
    self.current_station_index = 0
    current_station.arriving_train(self)
  end

  def move_forward
    route_validation!
    current_station.departure_train(self)
    @current_station_index += 1
    current_station.arriving_train(self)
  end

  def move_backward  
    route_validation!
    current_station.departure_train(self)
    @current_station_index -= 1
    current_station.arriving_train(self)
  end

  def current_station
    route_validation!
    route.stations[@current_station_index]
  end

  def passed_station
    route_validation!
    route.stations[@current_station_index - 1]
  end

  def next_station
    route_validation!
    route.stations[@current_station_index + 1]
  end

  private
  
  attr_writer  :route, :wagons
  attr_accessor :current_station_index
  
  def type_validation!(wagon)
    raise "Invalid type!" unless type.eql?(wagon.type)
  end
  
  def speed_validation!
    raise "Speed is not zero!" unless speed == 0
  end
  
  def wagon_connection_validation!(wagon)
    raise "Selected wagon not connected!" unless wagons.include?(wagon)
  end
  
  def route_validation!
    raise "Route couldn't be nil!" if route.nil?
  end
end
