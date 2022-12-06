# frozen_string_literal: true

class Location < ApplicationRecord
  def to_s
    "#{town}, #{county}"
  end

  # rubocop:disable Metrics/MethodLength
  def self.counties
    %w[
      Vrancea
      Satu Mare
      Bistriţa-Năsăud
      Tulcea
      Dâmboviţa
      Dolj
      Caraş-Severin
      Bihor
      Prahova
      Harghita
      Suceava
      Mureş
      Călăraşi
      Olt
      Botoşani
      Buzău
      Sibiu
      Gorj
      Bacău
      Arad
      Argeş
      Neamţ
      Cluj
      Vâlcea
      Constanţa
      Teleorman
      Ilfov
      Ialomiţa
      Hunedoara
      Bucureşti
      Sălaj
      Giurgiu
      Mehedinţi
      Covasna
      Iaşi
      Maramureş
      Braşov
      Brăila
      Vaslui
      Alba
      Timiş
      Galaţi
    ]
  end
  # rubocop:enable Metrics/MethodLength
end
