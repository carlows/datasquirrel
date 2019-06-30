class Group < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :gauges
  has_many :counts

  before_create do |user|
    user.name = user.name.parameterize if user.name.present?
  end
end
