# frozen_string_literal: true

class LoadReposJob < ApplicationJob
  queue_as :default

  def perform(repository_id)
    repo = Repository.find(repository_id)

    github_data = GithubClient.fetch_repo_data(repo)

    params = {
      name: github_data[:name],
      full_name: github_data[:full_name],
      language: github_data[:language].downcase,
      clone_url: github_data[:clone_url],
      ssh_url: github_data[:ssh_url],
      html_url: github_data[:html_url]
    }

    repo.update!(params)
    GithubClient.add_repo_webhook(repo)
  end
end
