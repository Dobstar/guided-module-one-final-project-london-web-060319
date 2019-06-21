class User < ActiveRecord::Base
    has_many :coffee_shops, through: :reviews
    has_many :reviews

    def full_name
        "#{self.first_name} #{self.last_name}"
    end 
    
    def all_reviews_content
        self.reviews.collect{|review| review.content}
    end 

    def all_star_ratings
        self.reviews.collect{|rating| rating.star_rating}
    end 
end 