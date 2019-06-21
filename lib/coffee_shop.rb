class CoffeeShop < ActiveRecord::Base
    has_many :reviews
    has_many :users, through: :reviews
    belongs_to :street

    def longest_content
        self.collect{|review| review.content}.max_by
        binding.pry
    end 
end 