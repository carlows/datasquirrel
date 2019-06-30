class Gauge < ApplicationRecord
  validates :slug, presence: true
  validates :value, presence: true

  belongs_to :group

  after_initialize do |metric|
    metric.slug = metric.slug.parameterize if metric.slug.present?
  end
end
