# frozen_string_literal: true

class House < ApplicationRecord
  belongs_to :footprint

  validates :electricity, presence: true
  validates :natural_gas, presence: true
  validates :wood, presence: true
  validates :carbon_footprint, presence: true
end
