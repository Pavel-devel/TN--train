# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        define_method(name) { instance_variable_get(var_name) }

        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          var_name_history ||= []
          var_name_history[var_name] << value
        end
      end
    end

    def strong_attr_accessor(name, name_class)
      var_name = "@#{name}".to_sym
      name_class.capitalize!
      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=") do |value|
        raise TypeError, "Invalid type of visible value!" unless value.is_a?(name_class)

        instance_variable_set(var_name, value)
      rescue TypeError => e
        puts e
        retry
      end
    end
  end
end
