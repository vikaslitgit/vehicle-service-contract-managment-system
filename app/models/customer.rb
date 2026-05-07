class Customer < ApplicationRecord
    has_many :vehicles, dependent: :destroy
    has_many :service_contracts, dependent: :destroy

    validates :email, 
            presence: true, 
            uniqueness: { case_insensitive: true }, 
            format: { with: URI::MailTo::EMAIL_REGEXP }
    
    validates :phone, format: { with: /\A\d{10}\z/, message: "must be 10 digits" }


    before_validation :upcase_state

    validates :state, presence: true
  
   validates :state, format: { with: /\A[A-Z]{2}\z/, message: "must be a 2-letter state abbreviation" }
   validates :zip_code, format: { with: /\A\d{5}\z/, message: "should be 5 digits" }
   validate :must_be_adult

   def full_name
    "#{first_name} #{last_name}"
   end

   def age
        (Date.today - date_of_birth).to_i/365
   end

  private

  def must_be_adult
    if age < 18
       errors.add(:date_of_birth, 'must be above 18 yeasr')
    end
  end

  def upcase_state
    self.state = state.upcase if state.present?
  end

end
