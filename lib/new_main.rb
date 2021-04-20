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
        information_text
        informant(gets.to_i)
      when 5
        wagons_space_text
        placementing(gets.to_i)
      else
        quit_flag = true
      end
    end
  end

  def seed
    self.stations_pool = [Station.new('SomeTitle1'), Station.new('SomeTitle2'),
                          Station.new('SomeTitle3'), Station.new('SomeTitle4'), Station.new('SomeTitle5')]
    self.routes_pool = [Route.new([stations_pool[0], stations_pool[1], stations_pool[2], stations_pool[3]]),
                        Route.new([stations_pool[4], stations_pool[3]])]
    PassengerWagon.new('198-ab', 'MaxIndustries', 100)
    PassengerWagon.new('198-aa', 'MaxIndustries', 100)
    CargoWagon.new('198-a1', 'MaxIndustries', 150)
    PassengerTrain.new('198-ad', 'MaxIndustries')
    Train.find_inst('198-ad').train_route = routes_pool[0]
    Train.find_inst('198-ad').wagon_connect(Wagon.find_inst('198-ab'))
  end

  private

  def greetings_text
    puts 'Welcome to the railroad control panel!'
    puts 'Press "1" to create an object'
    puts 'Press "2" to assign a route or change the number of wagons'
    puts 'Press "3" to move a train'
    puts 'Press "4" to view the list of trains at the station or connected wagons'
    puts 'Press "5" to take place or move from wagon'
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
    puts 'Press anything else to go back'
  end

  def moving_text
    puts 'Press "1" for moving forward'
    puts 'Press "2" for moving backward'
    puts 'Press anything else to go back'
  end

  def information_text
    puts 'Press "1" to see trains on station'
    puts 'Press "2" to see connected wagons'
    puts 'Press anything else to go back'
  end

  def wagons_space_text
    puts 'Press "1" and specify cell to take place in wagon'
    puts 'Press "2" and specify cell to move from wagon'
    puts 'Press anything else to go back'
  end

  def creating(input)
    case input
    when 1
      puts 'Specify train number and company: '
      puts "Successfully created train: #{create_passenger_train.number}"
    when 2
      puts 'Specify train number and company: '
      puts "Successfully created train: #{create_cargo_train.number}"
    when 3
      puts 'Specify station title: '
      puts "Successfully created station: #{create_station.last.title}"
    when 4
      puts 'Specify route stations'
      puts "Successfully created route: #{create_route.last.station_titles}"
    when 5
      puts 'Specify wagon number and company: '
      puts "Successfully created wagon: #{create_passenger_wagon.number}"
    when 6
      puts 'Specify wagon number and company: '
      puts "Successfully created wagon: #{create_cargo_wagon.number}"
    end
  end

  def create_cargo_wagon
    CargoWagon.new(gets.chomp, gets.chomp)
  rescue RuntimeError => e
    puts e.inspect
    create_cargo_wagon
  end

  def create_passenger_wagon
    PassengerWagon.new(gets.chomp, gets.chomp)
  rescue RuntimeError => e
    puts e.inspect
    create_passenger_wagon
  end

  def create_cargo_train
    CargoTrain.new(gets.chomp, gets.chomp)
  rescue RuntimeError => e
    puts e.inspect
    create_cargo_train
  end

  def create_passenger_train
    PassengerTrain.new(gets.chomp, gets.chomp)
  rescue RuntimeError => e
    puts e.inspect
    create_passenger_train
  end

  def create_station
    stations_pool.push(Station.new(gets.chomp))
  rescue RuntimeError => e
    puts e.inspect
    create_station
  end

  def create_route
    puts 'Select first station!'
    first_station = station_selection
    puts 'Select Second station!'
    second_station = station_selection
    routes_pool.push(Route.new([first_station, second_station]))
  rescue RuntimeError => e
    puts e.inspect
    create_route
  end

  def assigning(input)
    case input
    when 1
      wagon_mount
    when 2
      wagon_unmount
    when 3
      assign_route_to_train
    when 4
      add_station_to_the_route
    when 5
      remove_station_from_the_route
    end
  end

  def wagon_mount
    train_selection.wagon_connect(wagon_selection)
  rescue RuntimeError => e
    puts e.inspect
    wagon_mount
  end

  def wagon_unmount
    train_selection.wagon_disconnect(wagon_selection)
  rescue RuntimeError => e
    puts e.inspect
    wagon_unmount
  end

  def train_selection
    trains_list
    train = Train.find_inst(gets.chomp)
    train_validation!(train)
    train
  rescue RuntimeError => e
    puts e.inspect
    train_selection
  end

  def wagon_selection
    wagons_list
    wagon = Wagon.find_inst(gets.chomp)
    wagon_validation!(wagon)
    wagon
  rescue RuntimeError => e
    puts e.inspect
    wagon_selection
  end

  def station_selection
    stations_list
    station = stations_pool[gets.to_i]
    station_validation!(station)
    station
  rescue RuntimeError => e
    puts e.inspect
    station_selection
  end

  def route_selection
    routes_list
    route = routes_pool[gets.to_i]
    route_validation!(route)
    route
  rescue RuntimeError => e
    puts e.inspect
    route_selection
  end

  def trains_list
    Train.all.each { |x| puts "#{x.number}: #{x.class}" }
  end

  def wagons_list
    Wagon.all.each { |x| puts "#{x.number}: #{x.class}" }
  end

  def stations_list
    stations_pool.each_with_index { |x, index| puts "#{index}: #{x.title}" }
  end

  def routes_list
    routes_pool.each_with_index { |item, index| puts "#{index}: #{item.station_titles}" }
  end

  def assign_route_to_train
    train_selection.train_route = route_selection
  rescue RuntimeError => e
    puts e.inspect
    assign_route_to_train
  end

  def moving_train(train)
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
    train.move_forward
    if train.next_station.nil?
      train.route.route_reverse
      train.train_route = train.route
    end
  end

  def train_move_backward(train)
    train.move_backward
    if train.passed_station.nil?
      train.route.route_reverse
      train.train_route = train.route
    end
  end

  def informant(input)
    case input
    when 1
      station_selection.process_trains { |train| puts "Train number: #{train.number}, type: #{train.type}, number of wagons: #{train.wagons.length}" }
    when 2
      train_selection.process_wagons { |wagon| puts "Wagon number: #{wagon.number}, type: #{wagon.type}, space occupied: #{wagon.occupied} and space left: #{wagon.free_space}" }
    end
  end

  def placementing(input)
    case input
    when 1
      wagon_selection.take_space(gets.to_i)
    when 2
      wagon_selection.empty_space(gets.to_i)
    end
  end

  def remove_station_from_the_route
    route_selection.del_station(station_selection)
  rescue RuntimeError => e
    puts e.inspect
    remove_station_from_the_route
  end

  def add_station_to_the_route
    route_selection.add_station(station_selection)
  rescue RuntimeError => e
    puts e.inspect
    add_station_to_the_route
  end

  def train_validation!(train)
    raise 'You didn\'t select any train!' if train.nil?
  end

  def wagon_validation!(wagon)
    raise 'You didn\'t select any wagon!' if wagon.nil?
  end

  def station_validation!(station)
    raise 'You didn\'t select any station!' if station.nil?
  end

  def route_validation!(route)
    raise 'You didn\'t select any route!' if route.nil?
  end
end

rr = RailRoad.new

rr.seed

rr.menu

puts 'Goodbye!'
