class Api::V1::CustomersController < ApplicationController
    before_action :set_customer, only: [:show, :delete, :update]

    def index
        customers = Customer.all
        render json: customers, status: :ok
    end

    def show
         render json: @customer, status: :ok
    end

    def update
        if @customer.update(customer_params)
            render json: @customer, status: :ok
        else
            render json: @customer.errors.full_messages , status: :unprocessable_entity 
        end
    end

     def create
        customer = Customer.new(customer_params)
        if customer.save
            render json: customer, status: :created
        else
            render json: customer.errors.full_messages , status: :unprocessable_entity 
        end
    end

    def delete

        if @customer.vehicles.present?
            render json: { errors: "Connot delete as customer have the vehicle"}
        else
            @customer.destroy
        end
    end

    private

    def set_customer
        @customer = Customer.find_by(id: params[:id])
    end

    def customer_params
        params.require(:customer).permit(:first_name, :last_name, :email, :phone, :date_of_birth, :address, :city, :state, :zip_code)
    end
end
