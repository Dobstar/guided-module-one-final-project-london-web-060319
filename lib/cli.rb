class CommandLineInterface
    attr_reader :prompt
    
    @current_user = nil 

    def initialize
        @prompt = TTY::Prompt.new
    end

    def greet
        puts "Welcome to Brew Review"
        prompt.ask('What is your name?', default: 'Anonymous')
        puts "Hello,#{current_user}I am Baristabot, I will be helping you on your coffee shop journey!"
        binding.pry
        0
        promp.select("What would you like to do first?", %w(FindYourLocalCoffeeShop MakeAReview ReviewsByYou))
    end 
    

    # def previous_user_reviews
    #     puts "Need a new coffee shop to chill? Or want to try a different brew?? We can help you with your decision, with loads of reviews at our fingertips!"
    #     puts "Please enter a coffee shop name:"
    #     #CoffeeShop.find_by(name: coffee_shop)
    # end 
end 
