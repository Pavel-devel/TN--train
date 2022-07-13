# frozen_string_literal: true
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(name, type, *params)
      @validations ||= []
      @validations << {name: name, type: type, param: param}
    end
  end
  
  module InstanceMethods
    def validate!
      self.class.validations.each do |validate|
        value = instance_variable_get("#{validate[:name]}")
        case validate[:type]
        when :presence
          raise ArgumentError, "Epty value" if value.nil? || value == ""
        when :format
          raise ArgumentError, "Wrong format" if value !~ validate[:param]
        when :type
          raise ArgumentError, "Wrong type" if value != validate[:param]
        end
      end
    end
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end
end
