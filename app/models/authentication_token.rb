# frozen_string_literal: true

class AuthenticationToken < ApplicationRecord
  belongs_to :user
  validates :token, presence: true
  scope :valid, -> { where { (expires_at.nil?) | (expires_at > Time.zone.now) } }
end
