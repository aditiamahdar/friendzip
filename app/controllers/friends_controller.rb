class FriendsController < ApplicationController
  # POST /friends
  def create
    if has_two_email?
      if can_be_friend?
        render json: {success: true}
      else
        render json: friendship_error
      end
    else
      render json: invalid_params_message, status: :unprocessable_entity
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def friend_params
      params.require(:friends)
    end

    def has_two_email?
      friend_params.uniq.length == 2
    end

    def invalid_params_message
      {
        success: false,
        messages: ['Please send 2 emails as body params']
      }
    end

    def can_be_friend?
      User.transaction do
        first_user = User.find_or_create_by(email: friend_params.first)
        second_user = User.find_or_create_by(email: friend_params.last)

        if first_user.persisted? && second_user.persisted?
          first_user.add_friend(second_user)
          return true
        else
          @errors = first_user.errors.full_messages + second_user.errors.full_messages
          return false
        end
      end
    end

    def friendship_error
      {
        success: false,
        messages: @errors.uniq
      }
    end
end
