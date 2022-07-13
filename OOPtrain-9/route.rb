# frozen_string_literal: true

class Route
  include Validation
  include InstanceCounter
  include Accessors

  attr_reader :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
    validate!
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    stations.delete(station)
  end

  def view_route
    stations.each { |station| puts station.name }
  end

  private

  attr_writer :stations

  def validate!
    raise "Station can't be nil!" if stations.any?(nil)
  end
end
