require 'securerandom'

class ServiceContract < ApplicationRecord
    belongs_to :customer
    belongs_to :vehicle

    COVERAGE_TYPE = %w[basic standard premium].freeze
    DURATIONS = [12, 24, 36, 48, 60].freeze

    validates :coverage_type, inclusion: { in: COVERAGE_TYPE }
    validates :coverage_duration_months, inclusion: { in: DURATIONS }

    validates :deductible_amount,  numericality: { greater_than_or_equal_to: 0 }
    validates :monthly_payment,  numericality: { greater_than: 0 }

    validates :start_date, presence: true
    validate :start_date_connot_be_past_date

    validate :vehicle_belong_to_same_customer

    before_validation :generate_contract_number, om: :create
    before_save :calculate_end_date

    scope :active, -> { where("end_date >= ? ", Date.today)}
    scope :expired, -> { where("end_date <? ", Date.today)}
    scope :for_customer, -> (id) { where(customer_id: id) }
    scope :by_coverage_type, -> (type) { where(by_coverage_type: type) }
    scope :recent, -> { order(created_at: :asc)}


    def active?
        end_date >= Date.today
    end

    def days_remaining
        (end_date - Date.today).to_i
    end

    def total_cost
        monthly_payment * coverage_duration_months
    end



    private

    def vehicle_belong_to_same_customer
        if vehicle.customer_id != customer_id
            errors.add(:vehicle, 'vehicle_belong_to_same_customer')
        end
    end

    def start_date_connot_be_past_date

        if start_date < Date.today
            errors.add(:start_date, 'start date cannot be of past date')
        end
    end

    def generate_contract_number
        date_data = Date.today.strftime("%Y%m%d")
        random_data = SecureRandom.alphanumeric(4) 

        self.contract_number = "SC-#{date_data}-#{random_data}"
    end

    def calculate_end_date
        self.end_date = start_date + (coverage_duration_months.to_i.months)
    end

end
