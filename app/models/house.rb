# frozen_string_literal: true

class House < ApplicationRecord
  belongs_to :footprint, optional: true

  validates :electricity, presence: true
  validates :natural_gas, presence: true
  validates :wood, presence: true
end
