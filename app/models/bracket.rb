class Bracket < ActiveRecord::Base

  #Callbacks
  before_validation :checkActive, on: :create
  after_save :bracketActive

  #Relationships 
  has_many :teams
  belongs_to :tournament
  has_many :registrations
  has_many :students, through: :registrations

  #Validations
  validates_presence_of :gender
  validates_numericality_of :max_students, :min_age, :max_age
  validate :minlessmax
  validate :valid_tournament_id

  # Scopes
  # by gender 
  scope :male, -> { where("gender = ?","Male") }
  scope :female, -> { where("gender = ?", "Female") }
  scope :active, -> { where("active = ?", true)}

  #by age group
  #this needs some clarification 

  #is full
  scope :full, -> { where("max_students = ? ", num_registered) }
  scope :not_full, -> { where("max_students > ?", num_registered) }


  #Methods
  def get_teams
  	return self.teams.to_a
  end



  private 
  #Custom validations

  def checkActive
    if self.tournament.active == true
      self.active = true
    else
      self.active = false
    end
  end

  def bracketActive
    if (self.active == false)
      regs = Registration.where('bracket_id = ?', self.id)
      regs.each do |reg|
        reg.active = false
        reg.save!
      end
    end
  end

  def minlessmax
  	return self.min_age < self.max_age 
  end

  #tournament id must exist in the system
  #AND end_date of that tournament is null 
  #i.e. tounament is active
  def valid_tournament_id
  	all_tournaments = Tournament.all.to_a.map{|u| u.id}
  	return all_tournaments.include?(self.tournament.id) && self.tournament.end_date.nil?
  end

  #HELPER FUNCTIONS
  def num_registered
	return self.registrations.to_a.length
  end 

end
