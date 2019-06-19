User.delete_all
Street.delete_all
Review.delete_all
CoffeeShop.delete_all
30.times do 

    User.create(
        first_name: Faker::Name.first_name, 
        last_name: Faker::Name.last_name
    )
end


s1 = Street.create(name: "Liverpool Street")
s2 = Street.create(name: "Moorgate")
s3 = Street.create(name: "Old Street")

CoffeeShop.create([
    { name: "Beany Green" , location: "41 Broadgate Cir, London, EC2M 2QS", street_id: s1.id },
    { name: "The Good Yard", location:"19, The Arcade, 19 Liverpool Street, London, EC2M 7PN", street_id: s1.id},
    { name: "Costa Coffee(Liverpool St Station)" , location: "18 Liverpool Street, London, EC2M 7PD", street_id: s1.id },
    { name: "Manon Cafe"  , location: "21 Copthall Ave, London, EC2R 7BS", street_id: s2.id },
    { name: "Ravello Cafe Co Ltd", location: "10 Telegraph St, London, EC2R 7AR", street_id: s2.id},
    { name:"Wild & Wood Coffee" , location: "47 London Wall, London, EC2M 5TE", street_id: s2.id},
    { name: "Shoreditch Grind", location: "213 Old St, Old Street, London, EC1V 9NR", street_id: s3.id },
    { name: "Workshop Coffee at White Collar Factory" , location: "1 Old Street Yard, Old Street, London EC1Y 8A", street_id: s3.id },
    { name: "Hermanos Colombian Coffee Roasters" , location: "Station Market Stall, Old St, Old Street, London EC1Y 1BE", street_id: s3.id},
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
