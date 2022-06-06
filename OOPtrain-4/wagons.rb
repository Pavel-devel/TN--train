class CargoWagon
  attr_reader :type

  def initialize
    @type = "Cargo"
  end
end

class PassengerWagon
  attr_reader :type
  
  def initialize
    @type = "Passenger"
  end
end