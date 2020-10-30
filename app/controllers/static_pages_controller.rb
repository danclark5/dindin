
class StaticPagesController < ApplicationController

  def home
  end

  def help
  end

  def about
  end

  def whats_new
  end

  def feedback_new
  end

  def feedback_post
    from = SendGrid::Email.new(email: 'dan@dnnrpckr.com')
    to = SendGrid::Email.new(email: 'clarkhouse3006@gmail.com')
    subject = 'Incoming DnnrPckr Feedback'
    content = SendGrid::Content.new(type: 'text/plain', value: feedback_params[:feedback])
    mail = SendGrid::Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers

    redirect_to :root, notice: 'Thank you for the feedback!'
  end

  private

  def feedback_params
    params.permit(:feedback)
  end
end
