# frozen_string_literal: true

class PublicTransportFootprintCalculator
  TRAIN = 0.041
  BUS = 0.105

  def initialize(total_km, transport_type)
    @total_km = total_km
    @transport_type = transport_type
  end

  def self.call(total_km, transport_type)
    new(total_km, transport_type).call
  end

  def call
    footprint_calculator
  end

  private

  attr_reader :total_km, :transport_type

  def footprint_calculator
    total_km * transport_type_mapping
  end

  def transport_type_mapping
    case transport_type
    when 0
      TRAIN
    when 1
      BUS
    end
  end
end
