require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'cargo_wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'menu_text.rb'
require_relative 'menu_cases.rb'
require_relative 'menu_activity.rb'
require_relative 'menu_info'

class RailRoad
  attr_accessor :stations_pool, :routes_pool, :wagons_pool, :trains_pool
  include MenuCases
  include MenuText
  include MenuActivity
  include MenuInfo

  def initialize
    self.stations_pool = [Station.new('someTitle1'), Station.new('someTitle2'),
                          Station.new('someTitle3'), Station.new('someTitle4'), Station.new('someTitle5')]
    self.routes_pool = [Route.new([stations_pool[0], stations_pool[1], stations_pool[2], stations_pool[3]]),
                        Route.new([stations_pool[4], stations_pool[3]])]
    self.wagons_pool = [PassengerWagon.new, PassengerWagon.new, CargoWagon.new]
    self.trains_pool = [PassengerTrain.new(1984)]
    trains_pool[0].wagon_connect(wagons_pool[0])
  end

  def menu
    greeting_text
    casing_(gets.to_i)
  end
end

rr = RailRoad.new

rr.menu

puts 'Goodbye!'
