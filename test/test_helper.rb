ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'simplecov' #simplecov gem for basic test coverage statistics
SimpleCov.start 'rails'
require 'turn/autorun' #gem to format unit test output


class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  #fixtures :all <- set the use of transactional fixtures to false by commenting out as per 272 instructions

  # Add more helper methods to be used by all tests here...

  def deny(condition)
    # a simple transformation to increase readability IMO
    assert !condition
  end
  
  def create_context
    
    #households
    @main = FactoryGirl.create(:household)
    @first = FactoryGirl.create(:household, street: "2 First Ave")
    @old = FactoryGirl.create(:household, street: "50 Old Dr", active: false)
    
    #students, need school
    @joe = FactoryGirl.create(:student, household: @main)
    @sue = FactoryGirl.create(:student, household: @first, first_name: "Sue", last_name: "Jones", emergency_contact_name: "Michael Jones", dob: 12.years.ago.to_date, grade: 6, gender: "female", has_birth_certificate: false, active: false)
    
    #users, need volunteer
    @userv = FactoryGirl.create(:user, volunteer: )
    @userc = FactoryGirl.create(:user, volunteer: , username: "itsme", role: "coach", email: "itsme@gmail.com")
    @useri = FactoryGirl.create(:user, volunteer: , username: "olduser", email: "olduser@gmail.com", active: false)

  end
  
  def remove_context
    
    @main.destroy
    @first.destroy
    @old.destroy
    
    @joe.destroy
    @sue.destroy
    
    @userc.destroy
    @userv.destroy
    @useri.destroy
    
  end


end

# Formatting test output a little nicer
Turn.config.format = :outline