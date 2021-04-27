# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module Validation
  class << self
    def included(base)
      base.extend Classmethods
      base.send :include, InstanceMethods
    end
  end

  module Classmethods
    def validate(args)
      @obj = args[:obj]
      @validation = args[:validation]
      @regexp = args[:regexp] || //
      @type = args[:type] || Object

      raise 'Object not presented!' if @validation == 'presence' && @obj.nil?
      raise "#{@obj} in the wrong format!" if @validation == 'format' && @obj !~ @regexp
      raise "Wrong object type! Expected #{@type}, but got #{@obj.class}" if @validation == 'type' && @obj.class.to_s != @type.to_s
    end
  end

  module InstanceMethods
    def validate!(attribute, expected_type, naming_format, number)
      self.class.validate(obj: attribute, validation: 'presence')
      self.class.validate(obj: number, regexp: naming_format, validation: 'format')
      self.class.validate(obj: attribute, type: expected_type, validation: 'type')
    end

    def valid?(attribute, expected_type, naming_format, number)
      validate!(attribute, expected_type, naming_format, number)
      true
    rescue StandardError
      false
    end
  end
end
