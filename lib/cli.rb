class CommandLineInterface
    attr_reader :prompt
    

    def initialize
        @prompt = TTY::Prompt.new
        @current_user = nil 
    end

    def new_user(f_name, l_name)
        @current_user = User.new
        @current_user.first_name = f_name
        @current_user.last_name = l_name
        @current_user.save
        binding.pry
    end

    def greet
        puts "Welcome to Brew Review"
        f_name = prompt.ask('What is your first name?', default: 'Anonymous')
        l_name = prompt.ask('What is your last name?', default: 'Anonymous')
        puts "Hello, #{f_name} #{l_name}. I am Baristabot, I will be helping you on your coffee shop journey!"
        new_user(f_name, l_name)
        
        
        prompt.select("What would you like to do first?", %w(FindYourLocalCoffeeShop MakeAReview ReviewsByYou))
    end 
    
    

    # def previous_user_reviews
    #     puts "Need a new coffee shop to chill? Or want to try a different brew?? We can help you with your decision, with loads of reviews at our fingertips!"
    #     puts "Please enter a coffee shop name:"
    #     #CoffeeShop.find_by(name: coffee_shop)
    # end 
end 
