class SessionsController < Devise::RegistrationsController
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)

    render :json => { :response => 'ok', :auth_token => current_user.authentication_token }.to_json, :status => :ok
  end
end