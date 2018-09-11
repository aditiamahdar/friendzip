class BlocksController < ApplicationController
  # POST /blocks
  def create
    if can_block?
      render json: success_response
    else
      render json: errors_response, status: :unprocessable_entity
    end
  end

  private
    def requestor_params
      params.require(:requestor)
    end

    def target_params
      params.require(:target)
    end

    def requestor
      @requestor ||= User.find_or_create_by(email: requestor_params)
    end

    def target
      @target ||= User.find_or_create_by(email: target_params)
    end

    def can_block?
      if requestor.persisted? && target.persisted?
        requestor.block(target)
      else
        @errors = requestor.errors.full_messages + target.errors.full_messages
        return false
      end
    end
end
