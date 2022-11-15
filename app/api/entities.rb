# frozen_string_literal: true

class Entities
  class User < Grape::Entity
    expose :email
    expose :first_name
    expose :last_name
  end

  class Flight < Grape::Entity
    expose :from
    expose :to
    expose :footprint_id
    expose :carbon_footprint
  end

  class Car < Grape::Entity
    expose :total_km
    expose :fuel_type
    expose :fuel_consumption
    expose :footprint_id
    expose :carbon_footprint
  end

  class PublicTransport < Grape::Entity
    expose :transport_type
    expose :total_km
    expose :footprint_id
    expose :carbon_footprint
  end

  class House < Grape::Entity
    expose :electricity
    expose :natural_gas
    expose :wood
    expose :footprint_id
  end

  class Food < Grape::Entity
    expose :footprint_id
  end
end
