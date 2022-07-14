# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(name, type, *param)
      @validations ||= []
      @validations << { name: name, type: type, param: param }
    end

    def validations
      @validations
    end
  end

  module InstanceMethods
    def validate!
      self.class.instance_variable_get("@validations").each do |hash|
        name = hash[:name]
        value = instance_variable_get("@#{name}")
        type = hash[:type]
        param = hash[:param][0]
        send("validate_#{type}", name, value, param)
      end
    end

    def validate_presence(name, value)
      raise "#{name} should be present!" if value.nil? || value.empty?
    end

    def validate_format(name, value, regexp)
      raise "Format #{name} should be #{regexp}" if value !~ regexp
    end

    def validate_type(name, value, type)
      raise "Type #{name} should be  #{type}" unless value.is_a?(type)
    end
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end
end
