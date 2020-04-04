class FeedbacksMailer < ApplicationMailer
  def send_feedback(params)
    @name = params[:name]
    @email = params[:email]
    @body = params[:body]

    admin_email = Admin.first.email

    mail to: [admin_email, ENV['APP_EMAIL']], subject: 'Feedback from TestGuru user'
  end
end