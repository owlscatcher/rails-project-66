# frozen_string_literal: true

class Api::ChecksController < Api::ApplicationController
  def create
    repository = Repository.find_by(github_id: params[:repository][:id])

    check = repository.checks.create!
    CheckReposJob.perform_later(check.id)

    head :ok
  end
end
