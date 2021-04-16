# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

module InstanceCounter
  class << self
    def included(base)
      base.extend ClassCounterMethods
      base.send :include, InstanceMethods
    end
  end

  module ClassCounterMethods
    attr_accessor :instances, :count

    def inherited(subclass)
      subclass.instance_eval do
        @instances = []
        @count = 0
      end
    end

    def all
      instances
    end

    def find_inst(number)
      instances.find { |x| x.number == number } || nil
    end

    def add_instance(instance)
      self.instances = instances.to_a << instance
      self.count = count.to_i + 1
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.add_instance(self)
      self.class.superclass.add_instance(self)
    end
  end
end
