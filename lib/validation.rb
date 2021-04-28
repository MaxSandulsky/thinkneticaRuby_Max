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
    def validate(args)
      @obj = args[:obj]
      @val = args[:val]
      @reg = args[:reg] || //
      @type = args[:type] || Object

      raise 'Object not presented!' if @val == 'presence' && @obj.nil?
      raise "#{@obj} in the wrong format!" if @val == 'format' && @obj !~ @reg
      raise "Wrong object type! Expected #{@type}, but got #{@obj.class}" if @val == 'type' && @obj.class.to_s != @type.to_s
    end
  end

  module InstanceMethods
    def validate!; end

    def valid?
      validate
      true
    rescue RuntimeError => e
      puts e.inspect
      false
    end
  end
end
