class CommandLineInterface
    def greet
        puts "Welcome to Brew Review"
    end 
    

    def previous_user_reviews(user_response)
        puts "Need a new coffee shop to chill? Or try a different brew?? We can help you with your decision!"
        puts "Please enter a coffee shop name:"
        CoffeeShop.find_by(name: coffee_shop_name)
    end 
end 
