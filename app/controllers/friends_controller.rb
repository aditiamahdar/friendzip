class FriendsController < ApplicationController
  # GET /friends
  def index
    @user = User.find_or_create_by(email: params[:email])
    if @user.persisted?
      render json: friend_list_response
    else
      @errors = @user.errors.full_messages
      render json: errors_response, status: :unprocessable_entity
    end
  end

  # POST /friends
  def create
    if has_two_email?
      if can_be_friend?
        render json: success_response
      else
        render json: errors_response, status: :unprocessable_entity
      end
    else
      render json: invalid_email_number, status: :unprocessable_entity
    end
  end

  # GET /friends/common
  def show
    if has_two_email?
      u1 = User.find_or_create_by(email: friend_params.first)
      u2 = User.find_or_create_by(email: friend_params.last)
      @friends_emails = u1.common_friends_with(u2)

      render json: friend_list_response
    else
      render json: invalid_email_number, status: :unprocessable_entity
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

    def invalid_email_number
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

    def friends_emails
      @friends_emails ||= @user.friends.pluck(:email)
    end

    def friend_list_response
      {
        success: true,
        friends: friends_emails,
        count: friends_emails.length
      }
    end
end
