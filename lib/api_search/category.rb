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

    def self.find_by_category(user_input)
      cat = self.all[user_input-1.to_i].name
      ApiSearch::Client.get_api_by_category(cat)
      user_cat = cat
      ApiSearch::API.print_api_info(user_cat)
    end
  end
end  