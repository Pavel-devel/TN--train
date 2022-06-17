module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_writer :instances

    def instances
      @instances
    end
  end
  
  protected

  module InstanceMethods
    def register_instance
      self.class.instances
    end
  end
end