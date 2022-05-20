class Station
attr_accessor :train 
attr_reader :trains_at_station

  def initialize(name)
    @name = name
    @trains_at_station = []
  end
  
  def add_to_st(train)
    @trains_at_station << train 		
  end
  
  def show_trains_at_station
    @trains_at_station.each { |train| train }		
  end
  
  def trains_type_size(type)
    @trains_at_station.select { |train| train.type == type }.size
  end

  def delete(train)
    @trains_at_station.delete(train)
  end
end 

class Route
  attr_reader :start, :finish, :middle

  def initialize(start, finish)
    @start = start
    @finish = finish
    @middle = []
  end

  def add_station(station)
    @middle << station
  end

  def remove_station(station)
    return unless @middle.include?(station)

    @middle.delete(station)
  end

  def stations
    [@start, @middle, @finish].flatten.compact
  end
end

class Train
attr_accessor :speed
attr_reader :current_station, :type

  def initialize(number, type, wagons, route, speed = 0)
    @number = number
    @type = type
    @wagons = wagons
    @speed = speed
    @staions_straight = route&.stations || = []
    @stations_pass = []
    @current_station = @staions_straight.shift
  end
  
  def go
    self.speed += 5
  end
  
  def return
    puts speed
  end
  
  def stop
    if speed > 0
      self.speed -= 5
    else
      false
    end
  end

  def add_num_wagons
    return "you need slow down" unless @speed == 0
      
    @wagons += 1
  end
  
  def get_num_wagons
    return "you need slow down" unless @speed == 0

    @wagons -= 1  
  end
  
  def move(action)
    case action
    when "up"
      up_action
    when "back"
      down_action
    else
    end
  end

  def next_station
    return if @staions_straight.empty?

    @staions_straight.first
  end

  def previous_station
    return if @stations_pass.empty?

    @stations_pass.last
  end

  private

  def up_action
    return "Move to straight is not allowed" unless next_station

    @stations_pass << @current_station
    @current_station = @staions_straight.shift
  end

  def down_action
    return "Move to back is not allowed" unless previous_station

    @staions_straight.unshift(@current_station)
    @current_station = @stations_pass.pop
  end
end  
