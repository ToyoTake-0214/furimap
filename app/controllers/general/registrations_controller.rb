class General::RegistrationsController < Users::RegistrationsController
  def new
    build_resource
    render "general/registrations/new"
  end

  def after_sign_up_path_for(resource)
    root_path
  end
end
