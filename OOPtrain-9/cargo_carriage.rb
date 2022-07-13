# frozen_string_literal: true

class CargoCarriage < Carriage
  def initialize(number_carriage, volume)
    super
    @type = :cargo
    validate!
  end

  def occupy_volume(volume)
    validate_volume!(volume)
    self.occupied_volume += volume if free_volume > volume
  end

  def validate_volume!(volume)
    errors = []
    errors << "Can't take more than the allowed volume" if volume > free_volume
    errors << "Volume can't be zero" if volume.zero?
    errors << "Volume can't be negative" if volume.negative?
    errors << "Volume can't be nil" if volume.to_f.nil?
    raise errors.join('. ') unless errors.empty?
  end

  private

  def validate!
    errors = []
    errors << 'Volume must be a number' unless volume.instance_of?(Float) || volume.instance_of?(Integer)
    super(errors)
  end
end
