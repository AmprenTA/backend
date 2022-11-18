# frozen_string_literal: true

class Food < ApplicationRecord
  belongs_to :footprint

  validates :min_carbon_footprint, presence: true
  validates :max_carbon_footprint, presence: true

end
