# frozen_string_literal: true

class Flight < ApplicationRecord
  belongs_to :footprint, optional: true

  validates :from, presence: true
  validates :to, presence: true
end
