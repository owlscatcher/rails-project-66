# frozen_string_literal: true

module Web
  class RepositoriesController < ApplicationController
    before_action :authenticate_user!, only: %i[index show new create]

    def index
      @repositories = current_user.repositories
    end

    def show
      @repository = current_user.repositories.find(params[:id])
    end

    def new
      @repository = current_user.repositories.build
      @users_repos = load_users_repos(current_user)
    end

    def create
      @repository = current_user.repositories.build(repository_params)

      if @repository.save
        redirect_to repositories_path, notice: t('.success')
      else
        flash.now['alert'] = t('.fail')
        render :new, status: :unprocessable_entity
      end
    end

    private

    def load_users_repos(user)
      client = Octokit::Client.new(access_token: user.token, auto_paginate: true)

      client.repos.map { |repo| [repo.name, repo.id] }
    end
  end
end
