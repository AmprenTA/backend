# frozen_string_literal: true

class Location < ApplicationRecord
  def to_s
    "#{town}, #{county}"
  end

  # rubocop:disable Metrics/MethodLength
  def self.counties
    %w[
      Alba
      Arad
      Argeş
      Bacău
      Bihor
      Bistriţa-Năsăud
      Botoşani
      Brăila
      Braşov
      Bucureşti
      Buzău
      Călăraşi
      Caraş-Severin
      Cluj
      Constanţa
      Covasna
      Dâmboviţa
      Dolj
      Galaţi
      Giurgiu
      Gorj
      Harghita
      Hunedoara
      Ialomiţa
      Iaşi
      Ilfov
      Maramureş
      Mehedinţi
      Mureş
      Neamţ
      Olt
      Prahova
      Sălaj
      Satu Mare
      Sibiu
      Suceava
      Teleorman
      Timiş
      Tulcea
      Vâlcea
      Vaslui
      Vrancea
    ]
  end
  # rubocop:enable Metrics/MethodLength
end
