class UpdatesController < ApplicationController
  # POST /updates
  def create
    if sender.persisted?
      render json: recipients_response
    else
      @errors = sender.errors.full_messages
      render json: errors_response, status: :unprocessable_entity
    end
  end

  private
    def sender_params
      params.require(:sender)
    end

    def text_params
      params.require(:text)
    end

    def sender
      @sender ||= User.find_or_create_by(email: sender_params)
    end

    def recipients_response
      {
        success: true,
        recipients: sender.recipients_of(text_params)
      }
    end
end
