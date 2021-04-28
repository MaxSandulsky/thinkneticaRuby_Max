require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'
require_relative 'validation.rb'
require_relative 'accessors.rb'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation
  extend Accessors

  attr_reader :route
  attr_accessor_with_history :speed

  def initialize(number, manufacturer)
    self.manufacturer = manufacturer
    self.number = number
    self.speed = 0
    register_instance
  end

  def wagon_connect(wagon)
    return unless speed.zero?
    self.wagons ||= []
    self.wagons = wagons + Array(wagon)
  end

  def wagon_disconnect(wagon)
    return unless speed.zero?
    return unless Array(wagons).include?(wagon)
    wagons.delete(wagon)
  end

  def process_wagons
    wagons.each { |wagon| yield(wagon) }
  end

  def speed_gain(velocity)
    self.speed = speed + velocity
  end

  def stop
    self.speed = 0
  end

  def train_route=(route_set)
    self.route = route_set
    route.validate
    self.current_station_index = 0
    current_station.arriving_train(self)
  end

  def move_forward
    route.validate
    current_station.departure_train(self)
    @current_station_index += 1
    current_station.arriving_train(self)
  end

  def move_backward
    route.validate
    current_station.departure_train(self)
    @current_station_index -= 1
    current_station.arriving_train(self)
  end

  def current_station
    route.validate
    route.stations[@current_station_index]
  end

  def passed_station
    route.validate
    route.stations[@current_station_index - 1]
  end

  def next_station
    route.validate
    route.stations[@current_station_index + 1]
  end

  def validate
    speed_validation
    current_station_index_validation
    wagons_validation
    manufacturer_validation
  end

  private

  attr_writer :route
  attr_accessor :current_station_index
  strong_attr_accessor(type: 'Wagon', name: 'wagons')

  def speed_validation
    self.class.validate(obj: speed, val: 'presence')
    self.class.validate(obj: speed, val: 'type', type: Integer)
  end

  def current_station_index_validation
    self.class.validate(obj: current_station_index, val: 'presence')
    self.class.validate(obj: current_station_index, val: 'type', type: Integer)
  end

  def wagons_validation
    wagons.each do |wagon|
      self.class.validate(obj: wagon, val: 'presence')
      self.class.validate(obj: wagon.number, val: 'format', reg: NUMBER_FORMAT)
      self.class.validate(obj: wagon, val: 'type', type: PassengerWagon)
    end
  end

  def manufacturer_validation
    self.class.validate(obj: manufacturer, val: 'presence')
    self.class.validate(obj: manufacturer, val: 'type', type: String)
  end
end
