class CountsController < ApplicationController
  before_action :require_slug, only: [:count, :group]
  before_action :set_group

  def emit
    @metric = @group.counts.new(count_params)

    if @metric.save
      render json: { status: 'ok' }, status: :created
    else
      render json: @metric.errors, status: :unprocessable_entity
    end
  end

  def count
    @counts = @group.counts.where(slug: params[:slug])
    @counts = Count.filter(@counts, params)

    render json: { total: @counts.count }, status: :ok
  end

  def group
    unless params[:by_month] || params[:by_week] || params[:by_day]
      render json: { error: 'Expecting parameter by_month or by_week or by day' }, status: :bad_request
      return
    end

    @counts = @group.counts.where(slug: params[:slug])
    @counts = Count.graph_filter(@counts, params)

    render json: { data: @counts }, status: :ok
  end

  private

  def require_slug
    unless params[:slug]
      render json: { error: 'Missing slug query param' }, status: :bad_request
      return
    end
  end

  def set_group
    @group = Group.find_by(name: params[:name])
  end

  def count_params
    params.permit(:slug)
  end
end
