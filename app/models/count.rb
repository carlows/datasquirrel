class Count < ApplicationRecord
  extend MetricFilters

  validates :slug, presence: true

  belongs_to :group

  before_create do |metric|
    metric.slug = metric.slug.parameterize if metric.slug.present?
  end
end
