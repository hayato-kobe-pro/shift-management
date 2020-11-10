class Room < ApplicationRecord
  has_many :relations
  has_many :schedules
end
