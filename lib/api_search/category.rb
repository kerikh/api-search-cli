require 'api_search/client'

module ApiSearch
  class Category 
    attr_accessor :name
    @@all = []

    def initialize(name)
      @name = name 
      @@all << self 
      @apis = []
    end

    def self.find_by_category(input)
      self.all[input-1]
    end
    
    def self.all 
      @@all
    end

    # method to add an api to a categorys api collection
    # tells the api to associate itself with a category(self)
    # so here an api belongs to a category
    def add_api(api)
      @apis << api
      api.category = self 
    end

    # instance method to selects all apis 
    # that belong to category
    # Ex: anime.apis (will return all anime apis)
    def apis
      Api.all.select {|api| api.category == self} 
    end 

    def add_api_by_name(name, description)
      api = Api.new(name, description)
      add_api(api)
    end

  end
end  