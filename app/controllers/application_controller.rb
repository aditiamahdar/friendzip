class ApplicationController < ActionController::API
  protected
    def success_response
      {
        success: true
      }
    end

    def errors_response
      {
        success: false,
        messages: @errors.uniq
      }
    end
end
