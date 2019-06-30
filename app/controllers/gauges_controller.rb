class GaugesController < ApplicationController
  before_action :set_group, only: [:emit, :latest, :mean]

  def emit
    @metric = @group.gauges.new(gauge_params)

    if @metric.save
      render json: { status: 'ok' }, status: :created
    else
      render json: @metric.errors, status: :unprocessable_entity
    end
  end

  def latest
    unless params[:slug]
      render json: { error: 'Missing slug query param' }, status: :bad_request
      return
    end

    @latest = @group.gauges.where(slug: params[:slug]).order(:created_at).last

    if @latest
      render json: { value: @latest.value }, status: :ok
    else
      render json: { error: 'metric not found' }, status: :bad_request
    end
  end

  def mean
    unless params[:slug]
      render json: { error: 'Missing slug query param' }, status: :bad_request
      return
    end

    @gauges = Gauge.filter(@group, params)

    render json: { value: @gauges.average(:value).try(:round, 2) }, status: :ok
  end

  private

  def set_group
    @group = Group.find_by(name: params[:name])
  end

  def gauge_params
    params.permit(:slug, :value)
  end
end
