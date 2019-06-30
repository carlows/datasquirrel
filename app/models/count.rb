class Count < ApplicationRecord
  validates :slug, presence: true

  belongs_to :group

  before_create do |metric|
    metric.slug = metric.slug.parameterize if metric.slug.present?
  end

  def self.filter(group, params)
    counts = group.counts.where(slug: params[:slug])

    if params[:current_month]
      from = Time.now.beginning_of_month.utc
      counts = counts.where('created_at >= ?', from)
    elsif params[:current_year]
      from = Time.now.beginning_of_year.utc
      counts = counts.where('created_at >= ?', from)
    end

    counts
  end
end
