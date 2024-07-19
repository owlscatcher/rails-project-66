# frozen_string_literal: true

class LoadReposJob < ApplicationJob
  queue_as :default

  def perform(user)
    client = Octokit::Client.new(access_token: user.token, auto_paginate: true)

    client.repos
  end
end
