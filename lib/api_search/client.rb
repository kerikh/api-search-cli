module ApiSearch
  class Client
    include Faraday

    def self.get_main
      Faraday.new(:url => 'https://api.publicapis.org/')
    end

    def self.get_categories
      response = self.get_main.get 'categories'
      categories = JSON.parse(response.body, symbolize_names: true)
      categories.map do |v|
        ApiSearch::Category.new(
        v.downcase 
        )
      end
    end


    def self.get_api_by_category(cat)
      response = self.get_main.get "entries?category=#{cat.split.first}"
      @items = JSON.parse(response.body, symbolize_names: true)
      @items[:entries].map do |h,**|
        api = ApiSearch::API.new(
          h[:API],
          h[:Description],
          h[:Auth],
          h[:HTTPS],
          h[:Cors],
          h[:Link],
          h[:Category]
        )
      end
    end

    def self.get_all_apis
      response = self.get_main.get 'entries'
      @items = JSON.parse(response.body, symbolize_names: true)
      @items[:entries].map do |h,**|
        api = ApiSearch::API.new(
          h[:API],
          h[:Description],
          h[:Auth],
          h[:HTTPS],
          h[:Cors],
          h[:Link],
          h[:Category]
        )
      end
    end

    def self.get_sample_api
      response = self.get_main.get 'random'
      @item = JSON.parse(response.body, symbolize_names: true)
      @item[:entries].map do |h,**|
        api = ApiSearch::API.new(
          h[:API],
          h[:Description],
          h[:Auth],
          h[:HTTPS],
          h[:Cors],
          h[:Link],
          h[:Category]
        )
      end
    end
  end
end