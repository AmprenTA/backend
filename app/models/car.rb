# frozen_string_literal: true

class Car < ApplicationRecord
  enum fuel_type: { diesel: 0, petrol: 1, gpl: 2, ev: 3, hybrid: 4 }

  belongs_to :footprint, optional: true

  validates :fuel_type, presence: true
  validates :total_km, presence: true
end
