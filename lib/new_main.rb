require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'cargo_wagon.rb'
require_relative 'passenger_wagon.rb'

class RailRoad
  attr_accessor :stations_pool, :routes_pool, :wagons_pool, :trains_pool

  def initialize

  end

  def menu
    wm_quit = false
    while wm_quit != true
      greetings_text
      case gets.to_i
      when 1
        creating_text
        creating(gets.to_i)
      when 2
        route_assign_wagons_text
        assigning(gets.to_i)
      when 3
        moving_train(train_selection)
      when 4
        station_list
      else
        wm_quit = true
      end
    end
  end
  
  def greetings_text
    puts 'Welcome to the railroad control panel!'
    puts 'Press "1" to create an object'
    puts 'Press "2" to assign a route or change the number of wagons'
    puts 'Press "3" to move a train'
    puts 'Press "4" to view the list of stations and the list of trains at the station'
    puts 'Press anything else to exit'
  end

  def creating_text
    puts 'What you want to create?'
    puts 'Press "1" to create a passenger train'
    puts 'Press "2" to create a cargo train'
    puts 'Press "3" to create a station'
    puts 'Press "4" to create a route'
    puts 'Press "5" to create a passenger wagon'
    puts 'Press "6" to create a cargo wagon'
    puts 'Press anything else to go back'
  end
  
  def route_assign_wagons_text
    puts 'Press "1" to mount wagon'
    puts 'Press "2" to unmount wagon'
    puts 'Press "3" to specify a route to the train'
    puts 'Press "4" to add station to the route'
    puts 'Press "5" to delete station from the route'
  end
  
  def moving_text
    puts 'Press "1" for moving forward'
    puts 'Press "2" for moving backward'
    puts 'Press anything else to go back'
  end
  
  def creating(input)
    case input
    when 1
      puts 'Specify train number: '
      puts 'This number is already taken' if create_passenger_train(gets.to_i).class != PassengerTrain
    when 2
      puts 'Specify train number: '
      puts 'This number is already taken' if create_cargo_train(gets.to_i).class != CargoTrain
    when 3
      puts 'Specify station title: '
      create_station(gets.chomp)
    when 4
      puts 'Specify route number: '
      create_route(gets.to_i)
    when 5
      self.wagons_pool.push(PassengerWagon.new)
    when 6
      self.wagons_pool.push(CargoWagon.new)
    end
  end
  
  def create_cargo_train(number)
    if trains_pool[number].nil?
      trains_pool[number] = CargoTrain.new(number)
    end
  end

  def create_passenger_train(number)
    if trains_pool[number].nil?
      trains_pool[number] = PassengerTrain.new(number)
    end
  end
  
  def create_station(title)
    stations_pool.push(Station.new(title))
  end
  
  def create_route(number)
    if self.routes_pool[number].nil?
      self.stations_pool.each_with_index { |x, index| puts "#{index + 1}: #{x.title}" }
      self.routes_pool[number] = Route.new(self.stations_selection)
    else puts 'This number is already taken or you make an error'
    end
  end
  
  def stations_selection
    add_station_array = []
    while true
      index = gets.chomp
      case index
      when '0'
        return add_station_array
      when /\d+/
        add_station_array.push(self.stations_pool[index.to_i - 1])
      else
        return nil
      end
    end
  end
  
  def assigning(input)
    case input
    when 1
      wagon_mount(train_selection, wagon_selection)
    when 2
      wagon_unmount(train_selection, wagon_selection)
    when 3
      assign_route_to_train(train_selection, route_selection)
    when 4
      add_station_to_the_route(route_selection, stations_selection)
    when 5
      remove_station_from_the_route(route_selection, stations_selection)
    end
  end
  
  def wagon_mount(train, wagon)
    train.wagon_connect(wagon)
  end

  def wagon_unmount(train, wagon)
    train.wagon_disconnect(wagon)
  end
  
  def train_selection
    self.trains_pool.each_with_index { |x, index| puts "#{index}: #{x.class}"}
    self.trains_pool[gets.to_i]
  end
  
  def wagon_selection
    self.wagons_pool.each_with_index { |x, index| puts "#{index}: #{x.class}" }
    self.wagons_pool[gets.to_i]
  end
  
  def route_selection
    self.routes_pool.each_with_index do |item, index|
      puts "#{index}: #{item.station_titles}"
    end
    self.routes_pool[gets.to_i]
  end
  
  def assign_route_to_train(train, route)
    train.train_route = route
  end
  
  def moving_train(train)
    moving_text
    direction = 1
    while direction != 0
      direction = gets.to_i
      case direction
      when 1
        train_move_forward(train)
      when 2
        train_move_backward(train)
      else
        direction = 0
      end
    end
  end
  
  def train_move_forward(train)
    puts "Train leaving: #{train.current_station.title}, next station: #{train.next_station.title}"
    train.move_forward
    if train.next_station.nil?
      train.route.route_reverse
      puts 'You have reach your destination, route rebuilt'
      train.train_route = train.route
    else
      puts "Train arriving to: #{train.current_station.title}, next station: #{train.next_station.title}"
    end
  end

  def train_move_backward(train)
    puts "Train leaving: #{train.current_station.title}, next station: #{train.passed_station.title}"
    train.move_backward
    if train.passed_station.nil?
      train.route.route_reverse
      puts 'You have reach your destination, route rebuilt'
      train.train_route = train.route
    else
      puts "Train arriving to: #{train.current_station.title}, next station: #{train.passed_station.title}"
    end
  end
  
  def station_list
    self.stations_pool.each { |x| puts "On station #{x.title}:
    Count of cargo trains: #{x.get_sorted_list(CargoTrain)}
    Count of passenger trains: #{x.get_sorted_list(PassengerTrain)}" }
  end
  
    def remove_station_from_the_route(route, station)
    station.each { |x| route.del_station(x) }
  end

  def add_station_to_the_route(route, station)
    station.each { |x| route.add_station(x) }
  end
  
  def seed
    self.stations_pool = [Station.new('someTitle1'), Station.new('someTitle2'),
                          Station.new('someTitle3'), Station.new('someTitle4'), Station.new('someTitle5')]
    self.routes_pool = [Route.new([self.stations_pool[0], self.stations_pool[1], self.stations_pool[2], self.stations_pool[3]]),
                        Route.new([self.stations_pool[4], self.stations_pool[3]])]
    self.wagons_pool = [PassengerWagon.new, PassengerWagon.new, CargoWagon.new]
    self.trains_pool = [PassengerTrain.new(1984)]
    self.trains_pool[0].wagon_connect(self.wagons_pool[0])
  end
end

rr = RailRoad.new
rr.seed
rr.menu

puts 'Goodbye!'
