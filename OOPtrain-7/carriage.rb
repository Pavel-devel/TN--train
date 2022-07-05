class Carriage
  include Validate
  include Manufacturer
  attr_reader :type, :number_carriage, :volume, :occupied_volume

  NUMBER_CARRIAGE_FORMAT = /^[a-z\d]{1}[a-z\d]{1}?$/i.freeze

  def initialize(number_carriage, volume)
    @number_carriage = number_carriage
    @volume = volume
    @occupied_volume = 0
  end

  def free_volume
    volume - occupied_volume
  end

  protected

  attr_writer :occupied_volume

  def validate!(errors = [])
    errors << "Volume can't be nil" if volume.nil?
    errors << "Volume can't be zero" if volume.zero?
    errors << "Volume must be positive" if volume.to_f.negative?
    errors << "Invalid number of carriage" if number_carriage !~ NUMBER_CARRIAGE_FORMAT
    raise errors.join('. ') unless errors.empty?
  end
end