class Vehicle < ApplicationRecord
    belongs_to :customer
    has_many :service_contracts, dependent: :restrict_with_error

    validates :vin, presence: true, length: {is: 17}, uniqueness: true,
                    format: { with:  /\A[A-HJ-NPR-Z0-9]{17}\z/, message: "must be an alphnumeric"}
    validates :year, presence: true, inclusion: { in: 1900..Date.today.year, message: "must be between 1900 and #{Date.today.year}"}
    validates :mileage, numericality: { greater_than_or_equal_to: 0 }

    def desciption
        "The description of the vehicle is the year #{year} and make #{make} and model is #{model} mileage is #{mileage} amd color is #{color}"
    end

    def age
        Date.today - year
    end

end
