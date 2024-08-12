# frozen_string_literal: true

module GithubClient
  class << self
    def client(user)
      ApplicationContainer['octokit_client'].new(access_token: user.token, auto_paginate: true)
    end

    def fetch_available_user_repos(user)
      client(user).repos
                  .select { |rep| Repository.language.value? rep.language&.downcase }
    end

    def fetch_repo_data(repository)
      client(repository.user).repo(repository.github_id)
    end

    def add_repo_webhook(repository)
      client(repository.user).create_hook(
        repository.github_id,
        'web',
        {
          url: Rails.application.routes.url_helpers.api_checks_url,
          content_type: 'json'
        },
        {
          events: ['push'],
          active: true,
          headers: {
            'bypass-tunnel-reminder' => 'true'
          }
        }
      )
    end
  end
end
