require_relative "manufacturing_company"
require_relative 'instance_counter'
require_relative 'validate'

class Train
  include Manufacture
  include InstanceCounter
  include Validate
  
  attr_accessor :route, :number
  attr_reader :speed, :quantity, :type
  
  @@all_train = []

  NUMBER_FORMAT = /^[a-z\d]{3}-*[a-z\d]{2}$/i
  
  def initialize(number)
    @number = number
    @speed  = speed
    @quantity = []
    @type = type
    @@all_train.push(self)
    register_instance
    validate!
  end

  def self.find(number)
    @@all_train.select { |i| i.number == number }.empty? ? nil : @@all_train.select { |i| i.number == number }
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    if @speed.zero? && wagon.type == type
      @quantity.push(wagon)
    else
      puts "Stop the train #{@speed} or choose another type wagon #{type}"
    end
  end

  def del_wagon(wagon)
    if @speed.zero? && wagon.type == type
      @quantity.delete(wagon)
    else
      puts "Look at #{@speed} or #{type}"
    end
  end

  def assign_a_route(route)
    @index_station = 0
    @route = route
    current_station = @route.station_all[@index_station]
    current_station.plus_train(self)
  end

  def current_station
    puts "ssdds" if @route.nil?

    @route.station_all[@index_station]
  end

  def next_station
    if route.station_all[@index_station + 1] != nil
      route.station_all[@index_station + 1]
    else
      puts 'Next station is does not exist'
    end
  end

  def previous_station
    if @index_station.positive?
      route.station_all[@index_station - 1]
    else
      puts 'Previous station station is does not exist'
    end
  end

  def move
    print "Station: #{route.station_all[@index_station + 1].name}"
    next_station.plus_train(self)
    current_station.delete_train(self)
    @index_station += 1
  end

  def back
    print "Station: #{route.station_all[@index_station - 1].name}"
    previous_station.plus_train(self)
    current_station.delete_train(self)
    @index_station -= 1
  end

  protected #not set in the interface

  attr_reader :index_station

  def validate!
    raise "Number has invalid format" if number !~ NUMBER_FORMAT
  end
end

class PassengerTrain < Train
  def initialize(number)
    super
    @speed = 0
    @type = 'Passenger'
  end
end

class CargoTrain < Train
  def initialize(number)
    super
    @speed = 0
    @type = 'Cargo'
  end
end