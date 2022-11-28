# frozen_string_literal: true

module CarbonFootprintHelper
  DIESEL = 2.7
  PETROL = 2.3
  GPL = 1.6
  EV = 0.053
  HYBRID = 0.109
  TRAIN = 0.041
  BUS = 0.105

  def calculate_car_footprint(total_km, fuel_consumption, fuel_type)
    liters_or_kwh_per_km = fuel_consumption / 100.0
    total_liters_or_kwh = total_km * liters_or_kwh_per_km
    total_liters_or_kwh * car_fuel_type_mapping(fuel_type)
  end

  def car_fuel_type_mapping(fuel_type)
    case fuel_type
    when 0
      DIESEL
    when 1
      PETROL
    when 2
      GPL
    when 3
      EV
    when 4
      HYBRID
    else
      error!('Bad request! Car fuel mapping went wrong!', 500)
    end
  end

  def calculate_pub_trans_footprint(total_km, transport_type)
    total_km * public_transport_type_mapping(transport_type)
  end

  def public_transport_type_mapping(transport_type)
    case transport_type
    when 0
      BUS
    when 1
      TRAIN
    else
      error!('Bad request! Public transport type mapping went wrong!', 500)
    end
  end
end
