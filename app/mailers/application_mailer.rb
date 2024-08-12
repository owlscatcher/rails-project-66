# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'info@rq.owlpaw.com'
  layout 'mailer'

  helper_method :asset_url
end
