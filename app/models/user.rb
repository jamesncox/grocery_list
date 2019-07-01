class User < ActiveRecord::Base
    has_secure_password
    has_many :items 

    def slug 
        username.downcase.gsub(" ", "-")
    end 
      
    def self.find_by_slug(slug)
        User.all.find do |user|
            user.slug == slug.downcase
        end
    end 
