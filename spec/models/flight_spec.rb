# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Flight do
  it { is_expected.to validate_presence_of(:total_km) }
  it { is_expected.to validate_presence_of(:from) }
  it { is_expected.to validate_presence_of(:to) }

  it { is_expected.to belong_to(:footprint) }
end
