require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :name, :train

  @@all = []

  def self.all
    @@all
  end

  def initialize(name)
    @name = name
    @train = []
    @@all.push(self)
    register_instance
  end
  
  def plus_train(train)
    @train.push(train)
  end

  def delete_train(train)
    @train.delete(train)
  end

  def show_all_train
    @train.each { |train| puts train }
  end

  private #Not set in the interface

  def type_train(type)
    @train.select { |train| train.type == type }
  end
end