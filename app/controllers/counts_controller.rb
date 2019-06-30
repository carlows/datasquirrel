class CountsController < ApplicationController
  before_action :set_group, only: [:increment, :count]

  def increment
    @metric = @group.counts.new(count_params)

    if @metric.save
      render json: { status: 'ok' }, status: :created
    else
      render json: @metric.errors, status: :unprocessable_entity
    end
  end

  def count
    unless params[:slug]
      render json: { error: 'Missing slug query param' }, status: :bad_request
      return
    end

    @counts = Count.filter(@group, params)

    render json: { total: @counts.count }, status: :ok
  end

  private

  def set_group
    @group = Group.find_by(name: params[:name])
  end

  def count_params
    params.permit(:slug)
  end
end
