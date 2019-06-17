class User < ActiveRecord::Base
    has_many :coffee_shops
    has_many :reviews
end 