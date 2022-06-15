require_relative "manufacturing_company"

class CargoWagon
  include Manufacture
  attr_reader :type

  def initialize
    @type = "Cargo"
  end
end

class PassengerWagon
  include Manufacture
  attr_reader :type
  
  def initialize
    @type = "Passenger"
  end
end