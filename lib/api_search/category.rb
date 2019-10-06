module ApiSearch
  class Category 
    attr_accessor :name
    @@all = []

    def initialize(name)
      @name = name 
      @@all << self 
      @apis = []
    end

    
    def self.all 
      @@all
    end
  end
end  