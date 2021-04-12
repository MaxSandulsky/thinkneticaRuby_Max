# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module MenuCases
  def casing_(input_)
    case input_
    when 1
      creating_text
      casing_what_to_create(gets.to_i)
    when 2
      manipulating_text
      casing_what_to_do(gets.to_i)
    when 3
      data_manipulations_text
      casing_what_to_enter(gets.to_i)
    end
  end

  def casing_what_to_create(input_)
    case input_
    when 1
      train_type_text
      casing_train_type(gets.to_i)
      casing_(1)
    when 2
      puts 'Specify station title: '
      create_station(gets.chomp)
      casing_(1)
    when 3
      station_selection_text
      create_route(casing_route_array)
      casing_(1)
    when 4
      wagon_type_text
      casing_wagon_type(gets.to_i)
      casing_(1)
    when 0
      menu
    end
  end

  def casing_what_to_do(input_)
    case input_
    when 1
      assign_route_to_train(route_selection, train_selection)
      casing_(2)
    when 2
      wagon_manipulation_text
      casing_wagon_manipulation(gets.to_i)
      casing_(2)
    when 3
      casing_train_movement(train_selection)
      casing_(2)
    when 0
      menu
    end
  end

  def casing_what_to_enter(input_)
    case input_
    when 1
      object_inspection_text
      casin_object_inspection(gets.to_i)
      casing_(3)
    when 2
      station_moving_text
      casin_station_moving(gets.to_i)
      casing_(3)
    when 3
      deliting_objects_text
      casing_deliting_objects(gets.to_i)
      casing_(3)
    when 0
      menu
    end
  end

  def casin_object_inspection(input_)
    case input_
    when 1
      train_inspection_text
      casing_train_inspection(gets.to_i)
      casing_(4)
    when 2
      station_inspection_text
      casiong_station_inspection(gets.to_i)
      casing_(4)
    when 3
      route_info(route_selection)
      casing_(4)
    when 4
      wagon_info(wagon_selection)
      casing_(4)
    end
  end

  def casing_wagon_type(input_)
    case input_
    when 1
      create_cargo_wagon
    when 2
      create_passenger_wagon
    when 0
      menu
    end
  end

  def casing_wagon_manipulation(input_)
    case input_
    when 1
      wagon_mount(wagon_selection, train_selection)
    when 2
      wagon_unmount(wagon_selection, train_selection)
    end
  end

  def casing_train_movement(train)
    train_moving_text
    loop do
      index = gets.to_i
      case index
      when 1
        train_move_forward(train)
      when 2
        train_move_backward(train)
      else break
      end
    end
  end

  def casing_train_type(input_)
    case input_
    when 1
      create_cargo_train
    when 2
      create_passenger_train
    when 0
      menu
    end
  end

  def casing_train_inspection(input_)
    case input_
    when 1
      train_nearby_stations_info(train_selection)
    when 2
      train_wagons_info(train_selection)
    when 3
      train_route_info(train_selection)
    end
  end

  def casiong_station_inspection(input_)
    case input_
    when 1
      station_title_info(station_selection)
    when 2
      station_passenger_train_info(station_selection)
    when 3
      station_cargo_train_info(station_selection)
    end
  end

  def casing_route_array
    add_station_array = []
    begin
      index = gets.chomp
      case index
      when '0'
        return add_station_array
      when /\d+/
        add_station_array.push(index.to_i - 1)
      else
        return nil
      end
    end while index.to_i > 0
  end

  def casin_station_moving(input_)
    case input_
    when 1
      add_station_to_the_way(station_selection, route_selection)
    when 2
      remove_station_from_the_way(station_selection, route_selection)
    end
  end

  def remove_station_from_the_way(station, route)
    route.del_station(station)
  end

  def add_station_to_the_way(station, route)
    route.add_station(station)
  end

  def casing_deliting_objects(input_)
    case input_
    when 1
      trains_pool.delete(train_selection)
    when 2
      stations_pool.delete(station_selection)
    when 3
      routes_pool.delete(route_selection)
    when 4
      wagons_pool.delete(wagon_selection)
    end
  end
end
