class Api::V1::ServiceContractsController < ApplicationController
    before_action :set_service_contract, only: [:show, :delete, :update]

    def index
        service_contracts = ServiceContract.all

        service_contracts = service_contracts.for_customer(params[:customer_id]) if params[:customer_id].present?
        service_contracts = service_contracts.for_customer(params[:coverage_type]) if params[:coverage_type].present?

        render json: service_contracts, status: :ok
    end

    def show
        render json: @service_contract, status: :ok
    end

    def update
        if @service_contract.update(service_contract_params)
            render json: @service_contract, status: :ok
        else
            render json: @service_contract.errors.full_messages , status: :unprocessable_entity 
        end
    end

     def create
        service_contract = ServiceContract.new(service_contract_params)
        if service_contract.save
            render json: service_contract, status: :created
        else
            render json: service_contract.errors.full_messages , status: :unprocessable_entity 
        end
    end

    def delete
       @service_contract.destroy
    end

    def active
        render json: ServiceContract.active, status: :ok
    end

    def expired
        render json: ServiceContract.expired, status: :ok
    end

    private

    def set_service_contract
        @service_contract = ServiceContract.find_by(id: params[:id])
    end

    def service_contract_params
        params.require(:service_contract).permit(:customer_id, :vehicle_id, :contract_number, :coverage_type, :coverage_duration_months, :deductible_amount, :monthly_payment, :start_date, :end_date, :notes)
    end
end
