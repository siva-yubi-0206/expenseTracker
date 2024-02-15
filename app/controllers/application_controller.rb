class ApplicationController < ActionController::Base
    include Pundit::Authorization

    rescue_from ActiveRecord::RecordInvalid, with: :handle_unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
    rescue_from StandardError, with: :handle_internal_server_error

    def required_attributes(object)
      object.attributes.except("created_at", "updated_at")
    end

    private
    def handle_unprocessable_entity(exception)
        render json: { error: exception.message }, status: :handle_unprocessable_entity
        return
    end

    def handle_not_found(exception)
      render json: { error: "Record not found" }, status: :not_found
      return
    end

    def handle_internal_server_error(exception)
        render json: { error: "Internal Server Error" }, status: :internal_server_error
        return
    end

    def current_user
      Thread.current[:user]
    end
end
  
