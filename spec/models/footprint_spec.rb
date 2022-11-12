# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Footprint do
  it { is_expected.to have_many(:cars) }
  it { is_expected.to have_many(:flights) }
  it { is_expected.to have_many(:public_transports) }
end
