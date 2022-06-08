class Station
  attr_reader :name, :train

  def initialize(name)
    @name = name
    @train = []
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