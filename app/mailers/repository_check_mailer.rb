# frozen_string_literal: true

class RepositoryCheckMailer < ApplicationMailer
  def check_failed(check_id)
    setup_mail_attributes(check_id)

    mail to: @user_email, subject: t('.failed', repository: @repo_name)
  end

  def check_have_problems(check_id)
    setup_mail_attributes(check_id)

    mail to: @user_email, subject: t('.have_problems', repository: @repo_name)
  end

  private

  def setup_mail_attributes(check_id)
    @check = Repository::Check.find(check_id)
    @problems_count = @check.problems.count
    @files_count = @check.files.count
    @user_email = @check.repository.user.email
    @repo_name = @check.repository.full_name
  end
end
