# frozen_string_literal: true

class CargoTrain < Train
  attr_reader :type

  validate :name, :format, NUMBER_TRAIN_FORMAT

  def initialize(number)
    super
    @type = :cargo
  end
end
