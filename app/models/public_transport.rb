# frozen_string_literal: true

class PublicTransport < ApplicationRecord
  enum transport_type: { train: 0, bus: 1 }

  belongs_to :footprint

  validates :transport_type, presence: true
  validates :total_km, presence: true
  validates :carbon_footprint, presence: true
end
