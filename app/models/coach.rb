class Coach < ActiveRecord::Base
	
    #Relationship Validations
	belongs_to :team
	has_one :user
	
end
