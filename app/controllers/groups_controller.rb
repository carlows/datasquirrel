class GroupsController < ApplicationController
  # POST /groups
  def create
    @group = Group.new(group_params)

    if @group.save
      render json: { name: @group.name }, include: [:name], status: :created
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  private

  def group_params
    params.permit(:name)
  end
end
