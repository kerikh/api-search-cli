require_relative './client'
require_relative './api'
require_relative './category'

module ApiSearch
  class CLI 

    def call
      welcome
      menu 
    end

    def welcome 
      puts "
      #             _____ _____                           _     
      #       /\   |  __ \_   _|                         | |    
      #      /  \  | |__) || |    ___  ___  __ _ _ __ ___| |__  
      #     / /\ \ |  ___/ | |   / __|/ _ \/ _` | '__/ __| '_ \ 
      #    / ____ \| |    _| |_  \__ \  __/ (_| | | | (__| | | |
      #   /_/    \_\_|   |_____| |___/\___|\__,_|_|  \___|_| |_|
      #                                                         
      #                                                         
      "
      puts 'Welcome to API Search!'
      puts '*' * 60
      pa "If you ever get lost, type 'help' to see list of commands.", :blue, :bright
      puts ''
    end
  
    def menu 
      pa "-"*50, :yellow
      puts "Hello! Ready to find an API for your next project?"
      puts "Lets Get Started!"
      pa "Choose your Destiny...", :yellow
      pa "-" * 50, :yellow
      puts " 1. Search by Category"
      puts " 2. Browse All APIs"
      puts " 3. Random API"
      pa "-" * 50, :yellow
      pa "Enter Number>>"
      
      input = gets.chomp
      
      menu_std(input)
    end
      
    def list_categories
      if ApiSearch::Category.all.size == 0
        ApiSearch::Client.get_categories
      else
        pa "-" * 50, :yellow
        pa "       ------- Categories -------   ", :green
        
        ApiSearch::Category.all.each.with_index do |cat, i|
          puts "#{i+1}. #{cat.name.titleize}"
        end

        pa "-" * 50, :yellow
        pa "What Api Category would you like to Browse?", :blue 
        puts "Enter Number>>"
      
        user_input = gets.chomp.to_i 
      
        select_category(user_input)
      end
    end


    def select_category(user_input)
      ApiSearch::Category.find_by_category(user_input)
            
      pa "Would you like to choose another Category or Return to the Main Menu?", :green 
      pa "Type category or menu"
      
      input = gets.chomp 
      
      menu_std(input)
    end

    def browse_all
      if ApiSearch::API.all.size <= 500
        ApiSearch::Client.get_all_apis
      else
        ApiSearch::API.print_all
        browse_all_range
      end
    end

    def browse_all_range
      if ApiSearch::API.all.size == 0
        ApiSearch::Client.get_all_apis
      else
        pa "-"*50, :yellow
        pa "There are a total of #{ApiSearch::API.all.length} results in this list.", :green
        pa "To see more results, please select a range...", :green
        pa "Example: 25-30  or 50-100"
        
        input = gets.chomp.sub('-','..')
        range = input.to_s
        
        ApiSearch::API.print_all(range)
        
        range_extra_menu
      end
    end

    def range_extra_menu
      pa "Would you like to see more?", :green 
      pa "Type Y for yes or N for no.", :green
      puts "Enter Selection>>"
      
      input = gets.chomp.titleize
      
      menu_std(input)
    end

    def print_random_api
      ApiSearch::Client.get_sample_api
      ApiSearch::API.random_api
      
      pa "Would you like to do another Random API search?", :green
      pa "Type 3 for a Random Search or Type menu to return to the Main Menu", :green 
      puts "Enter Selection>>"
      
      input = gets.chomp.downcase
      
      menu_std(input)
    end
      


    def menu_std(input) 
      loop do
        case input 
        when 'menu'
          menu 
        when 'exit'
          goodbye
        when 'help'
          menu 
        when 'Y'
          browse_all_range
        when 'N'
          menu
        when 'category'
          list_categories
        when '1'
          list_categories
        when '2'
          browse_all
        when '3'
          print_random_api
        else 
          input = ''
          pa "I dont understand your command. Please enter a valid selection", :red 
          puts "Type menu or exit"
          input = gets.chomp.downcase
        end
      end
    end
    

    def goodbye
      pa "-"*50, :green
      pa "Bye! Thanks for Browsing API Search...See You Soon!", :blue
      pa "-"*50, :green
      abort
    end
  end
end

puts ApiSearch::CLI.new.call