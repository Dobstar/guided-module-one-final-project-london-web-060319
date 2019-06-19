class CommandLineInterface
    attr_reader :prompt 
    attr_accessor :coffee_shop
    
    #def run 
    #end 

    def initialize
        @prompt = TTY::Prompt.new
        @current_user = nil 
        #@coffee_shop = coffee_shop
    end

    def new_user(f_name, l_name)
        @current_user = User.new
        @current_user.first_name = f_name
        @current_user.last_name = l_name
        @current_user.save
    end

    def greet
        puts "Welcome to Brew Review"
        f_name = prompt.ask('What is your first name?', default: 'Anonymous')
        l_name = prompt.ask('What is your last name?', default: 'Anonymous')
        puts "Hello, #{f_name} #{l_name}. I am Baristabot, I will be helping you on your coffee shop journey!"
        new_user(f_name, l_name)
        
        
        answer = prompt.select "What would you like to do first?", "Find Your Local Coffee Shop", "Make A Review", "Reviews By You"
    

        case answer
        when "Find Your Local Coffee Shop"
            street_locations_of_cs
        when "Make A Review"
            make_a_review
        else "Reviews By You"
            reviews_by_you
        end 
    end
    
    def street_locations_of_cs
        options = Street.all.map{|st| st.name}
        #options will iterate through and provide the street names available. By not hard coding it, it also means that if any street names were added it will be added to the end of the list (which is provided in the prompt below)
        street_answer = prompt.select "Please select your location:", options
        #options shows the street names.
        target_street = Street.all.find{|strt| strt.name==street_answer}
        #Iterating through the Street class, finding the street name that is == to the street answer (which is the options that were provided. ie. the street names found earlier.) 
        #So when selecting one of the options on the list shown on the cli.. it will then give you the information of that street. ie the coffee shops of that street.
        coffee_shops_per_street(target_street)
    end

    def coffee_shops_per_street(target_street)
        shop_options = CoffeeShop.all.map{|cs| cs.name if cs.street_id == target_street.id}.compact
        shop_answer = prompt.select "Please select which Coffee Shop you'd like to view:", shop_options
        chosen_shop = CoffeeShop.all.find{|c_shop| c_shop.name == shop_answer}

        deets_of_coffee_shops(chosen_shop)
    end 

    def deets_of_coffee_shops(chosen_shop)
        shop_deets = CoffeeShop.find_by_location(chosen_shop.location)
        shop_rv = Review.all.select{|rv| rv.content if rv.coffee_shop_id == chosen_shop.id}
        #shop_content = Review.all.find{|cs_rv| cs_rv.content == shop_rv}
        puts " "
        puts shop_deets.name
        puts " "
        puts shop_deets.location
        puts " "
        puts shop_rv[0].content
    end

    #def make_a_review
    #end

    #def reviews_by_you
    #end 
    # def previous_user_reviews
    #     puts "Need a new coffee shop to chill? Or want to try a different brew?? We can help you with your decision, with loads of reviews at our fingertips!"
    #     puts "Please enter a coffee shop name:"
    #     #CoffeeShop.find_by(name: coffee_shop)
    # end 
end 
