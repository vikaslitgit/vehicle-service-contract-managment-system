class Api::V1::VehiclesController < ApplicationController
    before_action :set_vehicle, only: [:show, :delete, :update]

    def index
        vehicles = Vehicle.all
        render json: vehicles, status: :ok
    end

    def show
        render json: @Vehicle, status: :ok
    end

    def update
        if @Vehicle.update(vehicle_params)
            render json: @Vehicle, status: :ok
        else
            render json: @Vehicle.errors.full_messages , status: :unprocessable_entity 
        end
    end

     def create
        vehicle = Vehicle.new(vehicle_params)
        if vehicle.save
            render json: vehicle, status: :created
        else
            render json: vehicle.errors.full_messages , status: :unprocessable_entity 
        end
    end

    def delete

        if @Vehicle.service_contracts.present?
            render json: { errors: "Connot delete as Vehicle have the service contract"}
        else
            @Vehicle.destroy
        end
    end

    private

    def set_Vehicle
        @Vehicle = Vehicle.find_by(id: params[:id])
    end

    def vehicle_params
        params.require(:Vehicle).permit(:customer_id, :vin, :year, :make, :model, :mileage, :color, :purchase_date)
    end
end

