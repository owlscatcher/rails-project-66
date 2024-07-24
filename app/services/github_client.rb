# frozen_string_literal: true

module GithubClient
  class << self
    def client(user)
      Octokit::Client.new(access_token: user.token, auto_paginate: true)
    end

    def fetch_available_user_repos(user)
      client(user).repos
                  .select { |rep| Repository.language.value? rep.language&.downcase }
    end

    def fetch_repo_data(repository)
      client(repository.user).repo(repository.github_id)
    end
  end
end
