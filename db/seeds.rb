30.times do 

    User.create(
        first_name: Faker::Name.first_name, 
        last_name: Faker::Name.last_name
    )
end

CoffeeShop.create([
    { name: "Beany Green" , location: "41 Broadgate Cir, London, EC2M 2QS" },
    { name: "The Good Yard", location:"19, The Arcade, 19 Liverpool Street, London, EC2M 7PN" },
    { name: "Costa Coffee(Liverpool St Station)" , location: "18 Liverpool Street, London, EC2M 7PD" },
    { name: "Manon Cafe"  , location: "21 Copthall Ave, London, EC2R 7BS" },
    { name: "Ravello Cafe Co Ltd", location: "10 Telegraph St, London, EC2R 7AR" },
    { name:"Wild & Wood Coffee" , location: "47 London Wall, London, EC2M 5TE" },
    { name: "Shoreditch Grind", location: "213 Old St, Old Street, London, EC1V 9NR" },
    { name: "Workshop Coffee at White Collar Factory" , location: "1 Old Street Yard, Old Street, London EC1Y 8A" },
    { name: "Hermanos Colombian Coffee Roasters" , location: "Station Market Stall, Old St, Old Street, London EC1Y 1BE"},
])

30.times do
    Review.create(
        user_id: User.all.sample.id, 
        coffee_shop_id: CoffeeShop.all.sample.id,
        content: Faker::Hacker.say_something_smart,
        star_rating: [1,2,3,4,5].sample
    )

end


puts "\n---------- SEEDED ------------\n\n"
