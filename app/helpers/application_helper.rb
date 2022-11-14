module ApplicationHelper
  def current_admin
    if admin_signed_in?
      Admin.find_by(id: warden.user.id)
    end
  end

  def admin_signed_in?
    !!(warden.user)
  end
end
