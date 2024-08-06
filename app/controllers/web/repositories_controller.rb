# frozen_string_literal: true

module Web
  class RepositoriesController < ApplicationController
    before_action :authenticate_user!, only: %i[index show new create]
    before_action :set_cached_repos, only: :new

    def index
      @repositories = current_user.repositories
    end

    def show
      @repository = current_user.repositories.find(params[:id])
    end

    def new
      @repository = current_user.repositories.build
    end

    def create
      @repository = current_user.repositories.find_or_initialize_by(repository_params)

      if @repository.save
        redirect_to repositories_path, notice: t('.success')
        LoadReposJob.perform_later(@repository.id)
      else
        flash.now['alert'] = t('.fail')
        render :new, status: :unprocessable_entity
      end
    end

    private

    def repository_params
      params.require(:repository).permit(:github_id)
    end

    def set_cached_repos
      @users_repos = Rails.cache.fetch("#{current_user.id}/repos", expires_in: 15.minutes) do
        GithubClient.fetch_available_user_repos(current_user)
      end
    end
  end
end
