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
            find_your_local_coffee_shop
        when "Make A Review"
            make_a_review
        else "Reviews By You"
            reviews_by_you
        end 
    end
    
    def find_your_local_coffee_shop
        street_answer = prompt.select "Please select your location:", "Liverpool Street", "Moorgate", "Old Street"
    

    case street_answer
    when "Liverpool Street"
        liverpool_street_coffee_shops
    when "Moorgate"
        moorgate_street_coffee_shops
    when
        "Old Street"
        old_street_coffee_shops
    end 
end

    def liverpool_street_coffee_shops
        liverpoool_street_answer = prompt.select "Your local coffee shops are:", "Beany Green", "The Good Yard", "Costa Coffee (Liverpool St Station)"
    

    case liverpool_street_answer
    when "Beany Green"
        method
    when "The Good Yard"
        method
    when "Costa Coffee (Liverpool St Station)"
        method
    end 
end

    def moorgate_street_coffee_shops
        moorgate_street_answer = prompt.select "Your local coffee shops are:", "Manon Cafe", "Ravello Cafe Co Ltd", "Wild & Wood Coffee"

        case moorgate_street_answer 
        when "Manon Cafe"
            method
        when "Ravello Cafe Co Ltd"
            method
        when "Wild & Wood Coffee"
            method
        end 
    end 
    
        def old_street_coffee_shops
            old_street_answer = prompt.select "Your local coffee shops are:", "Shoreditch Grind", "Workshop Coffee at White Collar Factory", "Hermanos Colombian Coffee Roasters"
            case old_street_answer
            when "Shoreditch Grind"
                method
            when "Workshop Coffee at White Collar Factory"
                method
            when "Hermanos Colombian Coffee Roasters"
                method
            end  
        end 

    def make_a_review
    end

    def reviews_by_you
    end 
    # def previous_user_reviews
    #     puts "Need a new coffee shop to chill? Or want to try a different brew?? We can help you with your decision, with loads of reviews at our fingertips!"
    #     puts "Please enter a coffee shop name:"
    #     #CoffeeShop.find_by(name: coffee_shop)
    # end 
end 
