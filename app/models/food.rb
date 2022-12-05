# frozen_string_literal: true

class Food < ApplicationRecord
  enum frequency: { never: 0, rarely: 1, sometimes: 2, often: 3, very_often: 4 }
  belongs_to :footprint

  validates :min_carbon_footprint, presence: true
  validates :max_carbon_footprint, presence: true
end
