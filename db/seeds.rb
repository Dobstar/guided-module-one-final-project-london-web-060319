30.times do 

    User.create(
        first_name: Faker::Name.first_name, 
        last_name: Faker::Name.last_name
    )

    CoffeeShop.create(
        name: Faker::Company.name, 
        location: Faker::Address.full_address
    )

    Review.create(
        user_id: User.all.sample.id, 
        coffee_shop_id: CoffeeShop.all.sample.id,
        content: Faker::Hacker.say_something_smart,
        star_rating: [1,2,3,4,5].sample
    )

end


puts "\n---------- SEEDED ------------\n\n"
