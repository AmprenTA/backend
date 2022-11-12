# frozen_string_literal: true

require 'rails_helper'

RSpec.describe House do
  it { is_expected.to validate_presence_of(:electricity) }
  it { is_expected.to validate_presence_of(:natural_gas) }
  it { is_expected.to validate_presence_of(:wood) }

  it { is_expected.to belong_to(:footprint) }
end
