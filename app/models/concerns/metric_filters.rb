module MetricFilters
  extend ActiveSupport::Concern

  def filter(records, params)
    if params[:current_month]
      from = Time.now.beginning_of_month.utc
    elsif params[:current_year]
      from = Time.now.beginning_of_year.utc
    end

    records = records.where('created_at >= ?', from) if from
    records
  end

  def graph_filter(records, params)
    records = filter(records, params)

    if params[:by_month]
      records = records.group_by_month(:created_at, format: '%b')
    elsif params[:by_week]
      records = records.group_by_week(:created_at, format: '%e %b')
    elsif params[:by_day]
      records = records.group_by_week(:created_at, format: '%e %b')
    end

    records.count
  end
end