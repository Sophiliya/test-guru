class Admin::BaseController < ApplicationController
  layout 'admin'

  before_action :admin_required!

  private

  def admin_required!
    if !current_user.admin?
      redirect_to root_path, alert: "Вы не авторизованы для просмотра этой страницы."
    end
  end
end
