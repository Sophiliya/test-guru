class HomeController < ApplicationController
  def index
    if user_signed_in? && current_user.sign_in_count == 1
      flash.now[:notice] = "Привет, #{current_user.email}!"
    end
  end

  def feedback
    FeedbacksMailer.send_feedback(feedback_params).deliver

    redirect_to root_path
  end

  private

  def feedback_params
    params.permit(:name, :email, :body)
  end
end
