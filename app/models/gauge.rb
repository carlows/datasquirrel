class Gauge < ApplicationRecord
  validates :slug, presence: true
  validates :value, presence: true

  belongs_to :group

  after_initialize do |metric|
    metric.slug = metric.slug.parameterize if metric.slug.present?
  end

  def self.filter(group, params)
    gauges = group.gauges.where(slug: params[:slug])

    if params[:current_month]
      from = Time.now.beginning_of_month.utc
      gauges = gauges.where('created_at >= ?', from)
    elsif params[:current_year]
      from = Time.now.beginning_of_year.utc
      gauges = gauges.where('created_at >= ?', from)
    end

    gauges
  end
end
