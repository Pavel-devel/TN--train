class Menu
  attr_reader :station, :train, :route, :wagon

  def initialize
    @station = []
    @route = 0
  end

  def start
    puts " \n\t Hellow #{`whoami`.chomp}!"

    hellow = <<~HERE
      \n
      In this interface, you can do the following:
           1: Create a new station
           2: Create a train
           3: Create route
           4: Add station
           5: Delete station
           6: Assign a route to a train
           7: Attach the wagon to the train
           8: Unhook the car from the train
           9: Move the train forward or backward along the route
          10: View the list of stations and the list of trains on the route
          11: Call Interface
          12: Exit the program
    HERE

    print "#{hellow}\n"
  end

  def choise
    state = true

    while state
      print "\n    --------------------------- "
      print "\n\nEnter transaction number: ~> "

      selection = gets.to_i

      case selection
        when 1 then send(:create_new_station)
        when 2 then send(:create_a_train)
        when 3 then send(:create_route)
        when 4 then send(:add_station)
        when 5 then send(:delete_station)
        when 6 then send(:assign_route)
        when 7 then send(:add_wagon)
        when 8 then send(:delete_wagon)
        when 9 then send(:next_back)
        when 10 then send(:curret)
        when 11 then send(:start)
        when 12
          puts "\nEnd of the program"
          state = false
      end
    end
  end

  def create_new_station
    puts "Enter the name of the new station"
    name_station = gets.chomp.to_s
  
    @station.push(Station.new(name_station))
    puts @station
  end

  def create_a_train
    print "\nEnter train type (1: Passsenger 2: Cargo)  ~> "
    selection = gets.to_i

    case selection
      when 1 then @train = PassengerTrain.new
      when 2 then @train = CargoTrain.new
    end

    puts @train
  end

  def create_route
    puts "\n You have created the following stations: "

    if @station.size >= 2

      (0...@station.length).each do |i|
        puts "\n#{i}) --- #{@station[i].name}\n"
      end

      puts "\nSelect start and end station"

      print "First station ~> "
      puts "Enter station by list number: "
      first = gets.to_i

      print "Last station ~> "
      puts "Enter station by list number: "
      last = gets.to_i

      @route = Route.new(@station[first], @station[last])

      puts @route
      
    else
      puts "\n<<< Add another station !!!"
    end
  end

  def add_station
    if @route != 0

      intermediate = @station - @route.station_all

      (0...intermediate.size).each do |i|
        puts "\n#{i}) --- #{intermediate[i].name}\n"
      end

      print "\nSelect a station ~>"
      add = gets.to_i

      @route.add_station(intermediate[add])

      puts @route

    else

      puts 'Designate a start and end station'
    end
  end

  def delete_station
    if @route.station_all.size <= 1

      puts "\nNothing to delete"

    else

      (0...@route.station_all.size).each do |i|
        puts "\n#{i}) -- #{@route.station_all[i].name}\n"
      end

      print "\nSelect a station ~>"
      dell = gets.to_i

      @route.del_station(@station[dell])

      puts @route
    end
  end

  def assign_route
    @train.assign_a_route(@route)
    puts @train.assign_a_route(@route)
  end

  def add_wagon
    print "\nSpecify the type of car (1: Passenger 2: Cargo) ~> "
    selection = gets.to_i

    case selection
    when 1 then @wagon = PassengerWagon.new
    when 2 then @wagon = CargoWagon.new
    end

    if @train.type == @wagon.type
      @train.add_wagon(@wagon)
      puts @train
    else
      puts 'Wagon/s and train of different types'
    end
  end

  def delete_wagon
    @train.del_wagon(@wagon)
    puts @train
  end

  def next_back
    print "\nWhere we go ? (1: Next 2: Back)  ~> "
    selection = gets.to_i

    case selection
    when 1 then  @train.move
    when 2 then  @train.back

    end
  end

  def curret
    puts @train.current_station
  end
end