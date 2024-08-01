# frozen_string_literal: true

class CheckReposJob < ApplicationJob
  queue_as :default

  def perform(repository_check_id)
    repository_check = Repository::Check.find repository_check_id

    return unless repository_check

    RepositoryCheckRunner.new.run(repository_check)

    nil if repository_check.passed?
  end
end
