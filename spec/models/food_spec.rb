# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Food do
  it { is_expected.to belong_to(:footprint) }
end
