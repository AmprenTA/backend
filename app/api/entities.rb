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
  end

  class Car < Grape::Entity
    expose :total_km
    expose :fuel_type
    expose :footprint_id
  end

  class PublicTransport < Grape::Entity
    expose :transport_type
    expose :total_km
    expose :footprint_id
  end

  class House < Grape::Entity
    expose :electricity
    expose :natural_gas
    expose :wood
    expose :footprint_id
  end

  class Transport < Grape::Entity
    expose :car, using: Car
    expose :flight, using: Flight
    expose :public_transport, using: PublicTransport
  end

  class Food < Grape::Entity
    expose :footprint_id
  end
end
