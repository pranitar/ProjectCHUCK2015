FactoryGirl.define do
  #schools
factory :school do
   name "Park Elementary School"
   district "Steel Valley"
   county "Allegheny"
end

  #students
  factory :student do
    association :household
    association :school
    first_name "Joe"
    last_name "Smith"
    dob 15.years.ago.to_date
    cell_phone "412-000-000"
    email "joe_smith@comcast.net"
    grade 9
    gender "male"
    emergency_contact_name "Jane Smith"
    emergency_contact_phone "412-000-0000"
    has_birth_certificate true
    allergies "none"
    medications "none"
    security_question "What is your dog's name?"
    security_response "Spot"
    active true
  end
  
  #households
  factory :household do
    street "100 Main St"
    city "Pittsburgh"
    state "PA"
    zip "15213"
    home_phone "412-000-0000"
    county "Allegheny"
    active true
  end

  #guardian
factory :guardian do
  association :household
   relation "mother"
   email "name@cmu.edu"
   first_name "Charlie"
   last_name "Batch"
   cell_phone "412-678-9000"
   receives_text_msgs true
   active true
end
  
  #users
  factory :user do
    association :volunteer
    username "user123"
    role "volunteer"
    email "user123@user.com"
    password_digest "secret"
    active true
  end

#volunteer
factory :volunteer do
   association :team
   role "volunteer"
   email "pranz@cmu.edu"
   first_name "Pranita"
   last_name "Ramakrishnan"
   cell_phone "571-478-3829"
   receives_text_msgs true
   active true
end

end