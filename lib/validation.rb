# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Validation
  NUMBER_FORMAT = /([a-zA-Z]|\d){3}-?([a-zA-Z]|\d){2}$/
  TITLE_FORMAT = /^[A-Z][a-z]+/

  class << self
    def included(base)
      base.extend Classmethods
      base.send :include, InstanceMethods
    end
  end

  module Classmethods  
    def validate(*args)
      @attribute = args[0]
      @validation = args[1].to_s
      @arguments = args[2]
      
      val_lambda = type_validation(@attribute, @arguments.to_s) if @validation == 'type'
      val_lambda = presence_validation(@attribute) if @validation == 'presence'
      val_lambda = format_validation(@attribute, @arguments) if @validation == 'format'
      val_lambda = array_type_var_validation(@attribute, @arguments.to_s) if @validation == 'array_type'
      
      val_array = instance_variable_get('@validation_methods'.to_sym)
      val_array ||= []
      val_array = val_array + Array(val_lambda)
      
      instance_variable_set('@validation_methods'.to_sym, val_array)
    end
    
    private
    
    def type_validation(attribute, type)
      lambda do |obj|
        raise "Wrong object type! Expected #{type}, but got #{obj.send(attribute).class.to_s}" if obj.send(attribute).class.to_s != type
      end
    end
    
    def presence_validation(attribute)
      lambda do |obj|
        raise "#{attribute} not presented!" if obj.send(attribute).nil? || obj.send(attribute).to_s.empty?
      end
    end
    
    def format_validation(attribute, format)
      lambda do |obj|
        raise "#{obj.send(attribute)} in the wrong format!" if obj.send(attribute) !~ format
      end
    end
    
    def array_type_var_validation(array, type)
        lambda do |obj|
          obj.send(array).each do |attribute|
            raise "Wrong object type! Expected #{type}, but got #{attribute.class.to_s}" if attribute.class.to_s != type && attribute.class.to_s != NilClass
        end
      end
    end
  end

  module InstanceMethods
    def validate!
      self.class.instance_variable_get('@validation_methods').each do |lmd|
        lmd.call(self)
      end
    end

    def valid?
      validate!
      true
    rescue RuntimeError => e
      puts e.inspect
      false
    end
    
    def nil_validation(object)
      raise "#{object} is null!" if object.nil?
    end
  end
end
