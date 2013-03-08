class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json
  
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "users/sessions#authentication_failure")
    set_flash_message(:notice, :signed_in) if is_navigational_format? 
    sign_in(resource) 
    resource.reset_authentication_token!

    render :status => 200, :json => { :success => true, :auth_token => resource.authentication_token, :user => resource }
  end

  def authentication_failure
    return render :json => {:success => false, :errors => alert}
  end
  
  def destroy  
    super  
  end
  
  protected
  def ensure_params_exist
    return unless params[:user_login].blank?
    render :json=>{:success=>false, :message=>"missing user_login parameter"}, :status=>422
  end
 
  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  end
end