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
      # existed_hook_id = find_existed_hook(repository)

      # if existed_hook_id.nil?
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
      # else
      #   client(repository.user).remove_hook(repository.github_id, existed_hook_id)
      #   add_repo_webhook(repository)
      # end
    end

    # def find_existed_hook(repository)
    #   hook_id = nil

    #   hooks = client(repository.user).hooks(repository.github_id)

    #   hooks.each do |hook|
    #     if hook.config.url == Rails.application.routes.url_helpers.api_checks_url
    #       hook_id = hook.id
    #     end
    #   end

    #   hook_id
    # end
  end
end
