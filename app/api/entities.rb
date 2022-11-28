# frozen_string_literal: true

class Entities
  class User < Grape::Entity
    expose :email
    expose :first_name
    expose :last_name
  end

  class House < Grape::Entity
    expose :electricity
    expose :natural_gas
    expose :wood
    expose :footprint_id
  end
end
