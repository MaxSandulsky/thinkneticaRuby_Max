# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.
require_relative 'instance_counter.rb'
require_relative 'manufacturer.rb'
require_relative 'train_validation.rb'

class Wagon
  include Manufacturer
  include InstanceCounter
  include TrainValidation
  
  attr_reader :max_space
  
  def initialize(number, manufacturer)
    self.manufacturer = manufacturer
    self.number = number

    validation!
    
    register_instance
  end
    
  def self.inherited(subclass)
    subclass.class_eval do
      attr_reader :max_space
      
      def take_space(cell_number)
        free_space_validation!(free_space)
        self.space.insert(cell_number, 1)
      end

      def empty_space(cell_number)
        self.space[cell_number] = 0
      end

      def occupied?(cell_number)
        space[cell_number] == 1
      end

      def occupied
        taken_space = space.select {|x| x == 1}
        taken_space.length
      end

      def free_space
        taken_space = space.select {|x| x == 1}
        max_space - taken_space.length
      end

      protected

      attr_accessor :space
      attr_writer :max_space

      def free_space_validation!(free_space)
        raise 'Not enough space!' if free_space <= 0
      end
    end
  end
end
