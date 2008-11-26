require 'date'

module Hashtostruct
  VERSION = '0.9.0'

  module StringToObject
    # Attempt to parse the string into a native Ruby object using standard formats
    def to_obj
      case self
      when /^(tru|fals)e$/
        self == 'true'
      when /^[+-]?\d+$/
        self.to_i
      when /^[+-]?\d+\.\d+$/ # floats
        self.to_f
      when /^[+-]?\d+(\.\d+)?[eE][+-]?\d+$/  # exponents
        self.to_f
      when /^(null|nil)$/
        nil
      when /^\d{2}:\d{2}(:\d{2}(\.\d+)?)?Z?$/
        DateTime.parse(self)
      when /^\d{2}:\d{2}:\d{2}[+-]\d{2}(:?\d{2})?$/
        DateTime.parse(self)
      when /^\d{4}-\d{2}(-\d{2})?$/
        DateTime.parse(self)
      when /^\d{4}-\d{2}-\d{2}[+-]\d{2}(:?\d{2})?$/
        DateTime.parse(self)
      when /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/
        DateTime.parse(self)
      else
        self
      end
    end
  end

  module ArrayToObject
    # iterates through the array, converting each string element to a native
    # element if possible and returns it
    def to_obj
      self.inject([]) do |res,elem|
        res << if elem.is_a?(String) or elem.is_a?(Array) or elem.is_a?(Hash)
                 elem.to_obj
               else
                 elem
               end
      end
    end
  end

  module HashToStruct
    VERSION = '1.0.0'

    # Takes a Hash and converts it into a Struct with each key as a property 
    # each value converted into a native object if possible.
    #
    # It currently looks for and converts:
    # * integers
    # * floats
    # * exponents into floats
    # * booleans
    # * DateTimes in the formats:
    #   * yyyy-mm
    #   * yyyy-mm-dd
    #   * yyyy-mm-dd hh:mm:ss
    #   * hh:mm
    #   * hh:mm:ss
    #   * hh:mm:ssZ
    #   * hh:mm:ss.ss
    #   * hh:mm:ss(+-)hh:mm
    #   * hh:mm:ss(+-)hhmm
    #   * hh:mm:ss(+-)hh
    def to_struct
      hash = self
      Struct.new(*(hash.inject([]) { |res,val| res << val[0].to_sym })).new(*(
        hash.inject([]) { |res,val| res << val[1].to_obj}
      ))
    end
    
    def to_obj
      to_struct
    end
  end
    
  Array.send  :include, ArrayToObject
  String.send :include, StringToObject
  Hash.send   :include, HashToStruct
end
