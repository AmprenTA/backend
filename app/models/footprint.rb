# frozen_string_literal: true

class Footprint < ApplicationRecord
  has_many :cars, dependent: :destroy
  has_many :flights, dependent: :destroy
  has_many :public_transports, dependent: :destroy

  has_one :house, dependent: :destroy
  has_one :food, dependent: :destroy

  belongs_to :user, optional: true
end
