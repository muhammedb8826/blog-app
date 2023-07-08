class Users::SessionsController < Devise::SessionsController
    skip_before_action :verify_authenticity_token
    respond_to :json
  
    private
  
    def respond_with(resource, _opts = {})
      render json: { message: 'You are logged in.'}, status: :ok
    end
  
    def respond_to_on_destroy
      current_user ? log_out_success : log_out_failed
    end
    def log_out_success
      render json: { message: "Logged out sucessfully." }, status: :ok
    end
    def log_out_failed
        render json: { message: "Something went wrong."}, status: :unauthorized
    end

end