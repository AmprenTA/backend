# frozen_string_literal: true

class Footprint < ApplicationRecord
  has_many :cars, dependent: :destroy
  has_many :flights, dependent: :destroy
  has_many :public_transports, dependent: :destroy

  has_one :house, dependent: :destroy
  has_one :food, dependent: :destroy

  belongs_to :user, optional: true

  def self.footprints_by_category_by_location(location)
    {
      min_food_footprints: Footprint.where(location:).joins(:food).pluck('foods.min_carbon_footprint'),
      max_food_footprints: Footprint.where(location:).joins(:food).pluck('foods.max_carbon_footprint'),
      cars_footprints: Footprint.where(location:).joins(:cars).pluck('cars.carbon_footprint'),
      house_footprints: Footprint.where(location:).joins(:house).pluck('houses.carbon_footprint'),
      flights_footprints: Footprint.where(location:).joins(:flights).pluck('flights.carbon_footprint'),
      public_transports_footprints: Footprint.where(location:).joins(:public_transports)
                                             .pluck('public_transports.carbon_footprint')
    }
  end

  def self.footprints_by_category
    {
      min_food_footprints: Footprint.joins(:food).pluck('foods.min_carbon_footprint'),
      max_food_footprints: Footprint.joins(:food).pluck('foods.max_carbon_footprint'),
      cars_footprints: Footprint.joins(:cars).pluck('cars.carbon_footprint'),
      house_footprints: Footprint.joins(:house).pluck('houses.carbon_footprint'),
      flights_footprints: Footprint.joins(:flights).pluck('flights.carbon_footprint'),
      public_transports_footprints: Footprint.joins(:public_transports)
                                             .pluck('public_transports.carbon_footprint')
    }
  end

  def self.footprints_by_category_with_timestamps
    result = {
      min_food_footprints: [],
      max_food_footprints: [],
      cars_footprints: [],
      house_footprints: [],
      flights_footprints: [],
      public_transports_footprints: []
    }

    all.each do |footprint|
      result[:min_food_footprints] << [footprint.food.min_carbon_footprint, footprint.created_at.strftime('%d/%m/%Y')] if footprint.food
      result[:max_food_footprints] << [footprint.food.max_carbon_footprint, footprint.created_at.strftime('%d/%m/%Y')] if footprint.food
      result[:cars_footprints] << [footprint.cars.sum(:carbon_footprint), footprint.created_at.strftime('%d/%m/%Y')]
      result[:house_footprints] << [footprint.house.carbon_footprint, footprint.created_at.strftime('%d/%m/%Y')] if footprint.house
      result[:flights_footprints] << [footprint.flights.sum(:carbon_footprint), footprint.created_at.strftime('%d/%m/%Y')]
      result[:public_transports_footprints] << [footprint.public_transports.sum(:carbon_footprint), footprint.created_at.strftime('%d/%m/%Y')]
    end

    result
  end

  def self.personal_footprints_by_category_with_timestamps(user)
    result = {
      min_food_footprints: [],
      max_food_footprints: [],
      cars_footprints: [],
      house_footprints: [],
      flights_footprints: [],
      public_transports_footprints: []
    }

    all.where(user:).each do |footprint|
      result[:min_food_footprints] << [footprint.food.min_carbon_footprint, footprint.created_at.strftime('%d/%m/%Y')] if footprint.food
      result[:max_food_footprints] << [footprint.food.max_carbon_footprint, footprint.created_at.strftime('%d/%m/%Y')] if footprint.food
      result[:cars_footprints] << [footprint.cars.sum(:carbon_footprint), footprint.created_at.strftime('%d/%m/%Y')]
      result[:house_footprints] << [footprint.house.carbon_footprint, footprint.created_at.strftime('%d/%m/%Y')] if footprint.house
      result[:flights_footprints] << [footprint.flights.sum(:carbon_footprint), footprint.created_at.strftime('%d/%m/%Y')]
      result[:public_transports_footprints] << [footprint.public_transports.sum(:carbon_footprint), footprint.created_at.strftime('%d/%m/%Y')]
    end

    result
  end
  
  def self.footprints_by_category_with_timestamps_and_location(location)
    result = {
      min_food_footprints: [],
      max_food_footprints: [],
      cars_footprints: [],
      house_footprints: [],
      flights_footprints: [],
      public_transports_footprints: []
    }

    all.where(location:).each do |footprint|
      result[:min_food_footprints] << [footprint.food.min_carbon_footprint, footprint.created_at.strftime('%d/%m/%Y')] if footprint.food
      result[:max_food_footprints] << [footprint.food.max_carbon_footprint, footprint.created_at.strftime('%d/%m/%Y')] if footprint.food
      result[:cars_footprints] << [footprint.cars.sum(:carbon_footprint), footprint.created_at.strftime('%d/%m/%Y')]
      result[:house_footprints] << [footprint.house.carbon_footprint, footprint.created_at.strftime('%d/%m/%Y')] if footprint.house
      result[:flights_footprints] << [footprint.flights.sum(:carbon_footprint), footprint.created_at.strftime('%d/%m/%Y')]
      result[:public_transports_footprints] << [footprint.public_transports.sum(:carbon_footprint), footprint.created_at.strftime('%d/%m/%Y')]
    end

    result
  end
end
