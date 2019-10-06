require_relative './client'
require 'paint/pa'
require 'ranger'

module ApiSearch
  class API

    attr_accessor :category, :title, :description, :auth, :cors, :url, :https
    
    # when api is initialized, push all to @@all
    @@all = []

    def initialize(title=nil, description=nil, auth=nil, https=nil, cors=nil, url=nil, category=nil)
      @title = title
      @description = description
      @auth = auth
      @https = https
      @cors = cors 
      @url = url 
      @category = category 
      save # calling save method 
    end

    # Can use Api.all to retrieve all Api Instances
    def self.all 
      @@all 
    end

    def save 
      @@all << self
    end

    def self.delete 
      @@all.clear 
    end

    def self.print_api_info
      pa "-----Api List from the Category: #{API.all.first.category}-----", :green
      pa "Total # of Results: #{API.all.length}", :green    
      
      API.all.each_with_index do |api,index|
        if api.title 
          puts "#{index+1} - #{api.title.titleize}"
          puts "     #{api.description}"
          puts "     #{api.url}"
          puts " Cors: #{api.cors} - Auth: #{api.auth} - Https: #{api.https}"
          pa "-" * 50, :blue 
        end
      end
    end

    def self.print_all(range = "1..25")
      begin
        valid_range = range.to_range
      rescue ArgumentError
        pa "Oops! That wasn't a valid range!", :red
      else
        pa "-"*50, :yellow
        pa "-------------Browse All APIs---------------"
        pa "Total # of APIs: #{API.all.length}", :green

        API.all[valid_range].each_with_index do |api,index|   
          if api.title 
            puts "#{index+1} - #{api.title.titleize}"
            puts "     #{api.description}"
            puts "     #{api.url}"
            puts "     Category: #{api.category}"
            puts " Cors: #{api.cors} - Auth: #{api.auth} - Https: #{api.https}"
            pa "-" * 50, :blue 
          end
        end
      end
    end

    def self.random_api 
      self.delete # added temp fix for a bug that would incorrectly pull random api after viewing categories.
      ApiSearch::Client.get_sample_api     
      pa "-"*40, :yellow
      pa "----------------Random Api-----------------", :green
      
      API.all.each_with_index do |api,index|
        if api.title 
          puts "#{index+1} - #{api.title.titleize}"
          puts "     #{api.description}"
          puts "     #{api.url}"
          puts "     Category: #{api.category}"
          puts " Cors: #{api.cors} - Auth: #{api.auth} - Https: #{api.https}"
          pa "-" * 50, :blue 
        end
      end
    end
  end
end