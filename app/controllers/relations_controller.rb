class RelationsController < ApplicationController
  before_action :set_relation, only: [:show, :update, :destroy]

  # GET /relations
  def index
    @relations = Relation.all

    render json: @relations
  end

  # GET /relations/1
  def show
    render json: @relation
  end

  # POST /relations
  def create
    @relation = Relation.new(relation_params)

    if @relation.save
      render json: @relation, status: :created, location: @relation
    else
      render json: @relation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /relations/1
  def update
    if @relation.update(relation_params)
      render json: @relation
    else
      render json: @relation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /relations/1
  def destroy
    @relation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_relation
      @relation = Relation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def relation_params
      params.require(:relation).permit(:user_id, :target_user_id, :friend, :subscribe, :block)
    end
end
