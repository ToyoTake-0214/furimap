class General::SessionsController < Users::SessionsController
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    render "general/sessions/new"
  end

  def after_sign_in_path_for(resource)
    root_path
  end
end
