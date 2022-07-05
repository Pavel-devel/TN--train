require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validate'
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'

class Main
  MENU = [
    { index: 1, title: "create new station", action: :create_new_station },
    { index: 2, title: "create new train", action: :create_new_train },
    { index: 3, title: "add new carriage to the train", action: :add_new_carriage },
    { index: 4, title: "remove carriage from the train", action: :remove_carriage },
    { index: 5, title: "create new route and manage on it", action: :manage_route },
    { index: 6, title: "set route for train", action: :set_route },
    { index: 7, title: "move train on the route", action: :move_train },
    { index: 8, title: "show stations and trains at the station", action: :show_station_and_trains },
    { index: 9, title: "show train and carriages on train", action: :show_train_and_carriages },
    { index: 10, title: "take place in carriage", action: :take_place },
    { index: 11, title: "occupy volume in carriage", action: :occupy_volume }
  ].freeze

  MENU_ROUTE = [
    { index: 1, title: "create new route", action: :create_new_route },
    { index: 2, title: "add station on route", action: :add_station },
    { index: 3, title: "delete station on route", action: :delete_station }
  ].freeze

  MENU_MOVE_TRAIN = [
    { index: 1, title: "move train or route to next station", action: :move_forward },
    { index: 2, title: "move train on route to previous station", action: :move_back }
  ].freeze

  def initialize
    @stations = []
    @routes = []
    @trains = []
    main_menu
  end

  def main_menu
    loop do
      puts "Enter your choice"
      MENU.each { |item| puts "#{item[:index]}: #{item[:title]}" }
      choice = gets.chomp.to_i
      need_item = MENU.find { |item| item[:index] == choice }
      send(need_item[:action])
      main_menu
      puts "Enter any key for continue or '0' for exit"
      break unless gets.chomp.to_i.zero?
    end
  end

  private

  def create_new_station
    puts "Enter name of the new station: "
    name = gets.chomp.to_sym
    @stations << Station.new(name)
    puts "Created new station: #{name}"
  end

  def create_new_train
    type = get_type
    number = get_number
    create_train(type, number)
  end

  def get_type
    puts "1: create passenger train"
    puts "2: create cargo train"
    choise = gets.chomp.to_i
    raise "Invalid enter! Please, repeat!" unless [1, 2].include?(choise)

    choise
  rescue RuntimeError => e
    puts e
    retry
  end

  def get_number
    puts "Enter number of the new train"
    number = gets.chomp.to_s
    raise "Invalid number! Please, repeat!" if number !~ Train::NUMBER_TRAIN_FORMAT

    number
  rescue RuntimeError => e
    puts e
    retry
  end

  def create_train(type, number)
    case type
    when 1
      @trains << PassengerTrain.new(number)
    when 2
      @trains << CargoTrain.new(number)
    end
    puts "Created new train with number: #{number}"
  end

  def get_number_carriage
    puts "Enter number of the new carriage"
    number = gets.chomp.to_s
    raise "Invalid number! Please, repeat!" if number !~ Carriage::NUMBER_CARRIAGE_FORMAT

    number
  rescue RuntimeError => e
    puts e
    retry
  end

  def get_place
    puts "Please enter number place"
    place = gets.chomp.to_i
    raise "Invalid number place" if place < 1

    place
  rescue RuntimeError => e
    puts e
    retry
  end

  def get_volume
    puts "Please enter volume"
    volume = gets.chomp.to_f
    raise "Invalid volume" if volume <= 0

    volume
  rescue RuntimeError => e
    puts e
    retry
  end

  def add_new_carriage
    train = select_from_collection(@trains)
    number = get_number_carriage
    case train
    when PassengerTrain
      place = get_place
      train.add_carriage(PassengerCarriage.new(number, place))
    when CargoTrain
      volume = get_volume
      train.add_carriage(CargoCarriage.new(number, volume))
    end
  end

  def remove_carriage
    train = select_from_collection(@trains)
    carriage = select_from_collection(train.carriages)
    train.remove_carriage(carriage)
  end

  def take_place
    train = select_from_collection(@trains)
    carriage = select_from_collection(train.carriages)
    carriage.take_place
  end

  def occupy_volume
    train = select_from_collection(@trains)
    carriage = select_from_collection(train.carriages)
    puts "Enter volume for occupy"
    volume = gets.chomp.to_f
    carriage.occupy_volume(volume)
  end

  def manage_route
    puts "Enter your choice"
    MENU_ROUTE.each { |item| puts "#{item[:index]}: #{item[:title]}" }
    choice = gets.chomp.to_i
    need_item = MENU_ROUTE.find { |item| item[:index] == choice }
    send(need_item[:action])
  end

  def create_new_route
    puts "Enter first station on route"
    first_station = select_from_collection(@stations)
    puts "Enter last station on roune"
    last_station = select_from_collection(@stations)
    @routes << Route.new(first_station, last_station) if first_station != last_station
  end

  def add_station
    puts "Enter name of new station on route"
    station = select_from_collection(@stations)
    route = select_from_collection(@routes)
    route.add_station(station)
  end

  def delete_station
    staition = select_from_collection(@stations)
    route = select_from_collection(@routes)
    route.delete_station(station)
  end

  def set_route
    train = select_from_collection(@trains)
    route = select_from_collection(@routes)
    train.set_route(route)
  end

  def move_train
    puts "Enter your choice"
    MENU_MOVE_TRAIN.each { |item| puts "#{item[:index]}: #{item[:title]}" }
    choice = gets.chomp.to_i
    need_item = MENU_MOVE_TRAIN.find { |item| item[:index] == choice }
    send(need_item[:action])
  end

  def move_forward
    train = select_from_collection(@trains)
    train.move_forward
  end

  def move_back
    train = select_from_collection(@trains)
    train.move_back
  end

  def show_station_and_trains
    station = select_from_collection(@stations)
    puts "Trains on station #{station}:"
    station.each_train do |train|
      puts "Number train: #{train.number}, type train: #{train.type}, carriages: #{train.carriages.size}"
    end
  end

  def show_train_and_carriages
    train = select_from_collection(@trains)
    puts "Carriages on train #{train}:"
    train.each_carriage do |carriage|
      puts "Number carriage: #{carriage.number_carriage}, type carriage: #{carriage.type},
      free place(volume): #{carriage.free_volume}, occupied place(volume): #{carriage.occupied_volume}"
    end
  end

  def show_collection(collection)
    collection.each.with_index(1) { |item, index| puts "#{index} : #{item}" }
  end

  def select_from_collection(collection)
    show_collection(collection)
    index = gets.to_i - 1
    return if index.negative?

    collection[index]
  end
end

Main.new