class GaugesController < ApplicationController
  before_action :set_group, only: [:emit]

  def emit
    @metric = @group.gauges.new(gauge_params)

    if @metric.save
      render json: { status: 'ok' }, status: :created
    else
      render json: @metric.errors, status: :unprocessable_entity
    end
  end

  private

  def set_group
    @group = Group.find_by(name: params[:name])
  end

  def gauge_params
    params.permit(:slug, :value)
  end
end
