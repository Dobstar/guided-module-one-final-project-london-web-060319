class CommandLineInterface
    attr_reader :prompt, :font, :pastel
    
    def initialize
        @prompt = TTY::Prompt.new
        @font = TTY::Font.new(:doom)
        @pastel = Pastel.new
        @current_user = nil 
    end
    
    def title
        puts pastel.bright_yellow(font.write("Brew  Review", letter_spacing: 2))
    end 

    def new_user(f_name, l_name)
        @current_user = User.find_or_create_by(first_name: f_name, last_name: l_name)

    end

    def greet
        puts "Welcome to Brew Review"
        f_name = prompt.ask('What is your first name?', default: 'Anonymous')
        l_name = prompt.ask('What is your last name?', default: 'Anonymous')
        puts "Hello, #{f_name} #{l_name}. I am Baristabot, I will be helping you on your coffee shop journey!"
        new_user(f_name, l_name)
        main_menu
    end 

    def main_menu

        answer = prompt.select "What would you like to do first?", "Find Your Local Coffee Shop", "Make A Review", "Reviews By You", "Exit"
    

        case answer
        when "Find Your Local Coffee Shop"
            street_locations_of_cs
        when "Make A Review"
            make_a_review
        when "Reviews By You"
            reviews_by_you
        else "Exit"
            exit
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
        shop_options = CoffeeShop.all.select {|cs| cs.street_id == target_street.id}.map {|cs| cs.name}
        #shop options = CoffeeShop.find_by_name
        shop_answer = prompt.select "Please select which Coffee Shop you'd like to view:", shop_options
        chosen_shop = CoffeeShop.all.find{|c_shop| c_shop.name == shop_answer}
        #chosen_shop = CoffeeShop.find_by_name(name: name)
        deets_of_coffee_shops(chosen_shop)
    end 

    def deets_of_coffee_shops(chosen_shop)
        shop_deets = CoffeeShop.find_by_location(chosen_shop.location)
        puts shop_deets.name
        puts "--------------------------------------------"
        puts shop_deets.location
        puts ""
        puts "*******************************************"
        puts ""
        shop_rv = Review.all.select{|rv| rv.coffee_shop_id == chosen_shop.id}
        puts "-------------------------------------------"
        puts "Star Rating: #{shop_rv[0].star_rating}/5"
        puts "-------------------------------------------"

        
        go_back = prompt.select "You may now, go back to Main Menu or Exit:","Main Menu", "Exit"
        case go_back
        when "Main Menu"
            main_menu
        else "Exit"
            exit
        end
    end 
        

    def make_a_review
        street_options = Street.all.map{|st| st.name}
        response = prompt.select "Thank you for taking the time to write a review. Please select from the following locations:",street_options
        selected_location = Street.all.find{|strt| strt.name==response}
        which_cs(selected_location)
    end


    def which_cs(selected_location)
        cs_options = CoffeeShop.all.map{|cs| cs.name if cs.street_id == selected_location.id}.compact
        cs_answer = prompt.select "Please select which Coffee Shop you'd like to write a review for:", cs_options
        a_coffee_shop = CoffeeShop.all.find{|c_shop| c_shop.name == cs_answer}
        create_review(a_coffee_shop)
    end


    def create_review(a_coffee_shop)
        review_content = prompt.ask('What would you like to say?')
        review_stars = prompt.ask("How many stars would you like to put between 1-5?")
        new_review = Review.create(:content=>"#{review_content}", :star_rating=>"#{review_stars}", :user_id=>"#{@current_user.id}", :coffee_shop_id=>"#{a_coffee_shop.id}")
        prompt.ok("Thanks for your feedback! You will now be sent back to the Main Menu now.")
        sleep 2
        main_menu
    end

   
    def reviews_by_you
         all_rev = Review.where(user_id: @current_user.id).map {|rev| rev.content}
         @current_user.reviews.each do |review|
            puts review.coffee_shop.name
            puts review.content
            puts review.star_rating
        end 
        if all_rev.count > 0 
            option_drop_downs(all_rev)
        else
            puts "You have 0 Reviews yet :-( !"
            sleep 3
            main_menu
        end 
    end 

    def option_drop_downs(all_rev)
        selected_rev = prompt.select("Pick one review", [all_rev])
        review_option = prompt.select "Would you like to edit or delete a review?",["Edit", "Delete", "Go Back"]
        review = Review.find_by(content: selected_rev)
        
        selected_rating=@current_user.all_star_ratings
        rating = Review.find_by(star_rating: selected_rating)

        if review_option == "Edit"
            review_content = prompt.ask "Please enter your new review:"
            review.update(content: review_content)
            review_star_rating = prompt.ask "How many stars would you like to give this coffee shop between 1-5?"
            rating.update(star_rating: review_star_rating)
            prompt.ok("Thats a great review! Thanks for your feedback. You will now be sent back to the Main Menu.")
            sleep 3
            main_menu
        elsif review_option == "Delete"
            Review.destroy(review.id)
            @current_user = User.find(@current_user.id)
            prompt.ok("Review is now deleted. You are now being sent back to the Main Menu")
            sleep 3
            main_menu
        else review_option == "Go Back"
            main_menu
        end 
    end 
end 