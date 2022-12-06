# frozen_string_literal: true

class Location < ApplicationRecord
  def to_s
    "#{town}, #{county}"
  end
end
