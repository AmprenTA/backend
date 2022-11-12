# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicTransport do
  it { is_expected.to validate_presence_of(:total_km) }
  it { is_expected.to validate_presence_of(:transport_type) }

  it { is_expected.to belong_to(:footprint) }
end
