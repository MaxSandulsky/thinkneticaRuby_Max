require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_wagon.rb'
require_relative 'cargo_wagon.rb'

class RailRoad
  attr_accessor :stations_pool, :routes_pool

  def initialize; end

  def menu
    quit_flag = false
    until quit_flag
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
        quit_flag = true
      end
    end
  end

  def seed
    self.stations_pool = [Station.new('someTitle1'), Station.new('someTitle2'),
                          Station.new('someTitle3'), Station.new('someTitle4'), Station.new('someTitle5')]
    self.routes_pool = [Route.new([stations_pool[0], stations_pool[1], stations_pool[2], stations_pool[3]]),
                        Route.new([stations_pool[4], stations_pool[3]])]
    PassengerWagon.new(1, 'MaxIndustries')
    PassengerWagon.new(2, 'MaxIndustries')
    CargoWagon.new(3, 'MaxIndustries')
    PassengerTrain.new(1984, 'MaxIndustries')
    Train.find_inst(1984).wagon_connect(Wagon.find_inst(1))
  end

  private

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
      puts 'Specify train number and company: '
      puts 'This number is already taken' unless create_passenger_train(gets.to_i, gets.to_s)
    when 2
      puts 'Specify train number and company: '
      puts 'This number is already taken' unless create_cargo_train(gets.to_i, gets.to_s)
    when 3
      puts 'Specify station title: '
      create_station(gets.chomp)
    when 4
      puts 'Specify route number: '
      create_route(gets.to_i)
    when 5
      puts 'Specify train number and company: '
      puts 'This number is already taken' unless PassengerWagon.new(gets.to_i, gets.to_s)
    when 6
      puts 'Specify train number and company: '
      puts 'This number is already taken' unless CargoWagon.new(gets.to_i, gets.to_s)
    end
  end

  def create_cargo_wagon(number, prodaction_company)
    CargoWagon.new(number, prodaction_company) if Wagon.find_inst(number).nil?
  end

  def create_passenger_wagon(number, prodaction_company)
    PassengerWagon.new(number, prodaction_company) if Wagon.find_inst(number).nil?
  end

  def create_cargo_train(number, prodaction_company)
    CargoTrain.new(number, prodaction_company) if Train.find_inst(number).nil?
  end

  def create_passenger_train(number, prodaction_company)
    PassengerTrain.new(number, prodaction_company) if Train.find_inst(number).nil?
  end

  def create_station(title)
    stations_pool.push(Station.new(title))
  end

  def create_route(number)
    if routes_pool[number].nil?
      stations_pool.each_with_index { |x, index| puts "#{index + 1}: #{x.title}" }
      routes_pool[number] = Route.new(stations_selection)
    else puts 'This number is already taken or you make an error'
    end
  end

  def stations_selection
    add_station_array = []
    loop do
      index = gets.chomp
      case index
      when '0'
        return add_station_array
      when /\d+/
        add_station_array.push(stations_pool[index.to_i - 1])
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
    train.wagon_connect(wagon) unless train.nil?
  end

  def wagon_unmount(train, wagon)
    train.wagon_disconnect(wagon) unless train.nil?
  end

  def train_selection
    Train.all.each { |x| puts "#{x.number}: #{x.class}" }
    Train.find_inst(gets.to_i)
  end

  def wagon_selection
    Wagon.all.each { |x| puts "#{x.number}: #{x.class}" }
    Wagon.find_inst(gets.to_i)
  end

  def route_selection
    routes_pool.each_with_index do |item, index|
      puts "#{index}: #{item.station_titles}"
    end
    routes_pool[gets.to_i]
  end

  def assign_route_to_train(train, route)
    train.train_route = route unless train.nil?
  end

  def moving_train(train)
    return nil if train.route.nil?
    moving_text
    direction = 1
    until direction == 0
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
    Station.all.each do |x|
      puts "On station #{x.title}:
    Count of cargo trains: #{x.get_sorted_list(CargoTrain)}
    Count of passenger trains: #{x.get_sorted_list(PassengerTrain)}" end
  end

  def remove_station_from_the_route(route, station)
    station.each { |x| route.del_station(x) }
  end

  def add_station_to_the_route(route, station)
    station.each { |x| route.add_station(x) }
  end
end

rr = RailRoad.new

rr.seed

rr.menu

puts 'Goodbye!'
