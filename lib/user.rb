class User < ActiveRecord::Base
    has_many :coffee_shops
    has_many :reviews

    def full_name
        "#{self.first_name}#{self.last_name}"
    end 
end 