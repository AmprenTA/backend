# frozen_string_literal: true

class Flight < ApplicationRecord
  belongs_to :footprint

  validates :from, presence: true
  validates :to, presence: true
  validates :carbon_footprint, presence: true
end
