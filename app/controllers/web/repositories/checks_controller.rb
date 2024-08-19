# frozen_string_literal: true

module Web
  module Repositories
    class ChecksController < ApplicationController
      before_action :set_cached_check, only: :show
      def show
        authorize @check
      end

      def create
        @check = resource_repository.checks.build

        authorize @check

        if @check.save
          CheckReposJob.perform_later(@check.id)

          redirect_to repository_path(resource_repository), notice: t('.success')
        else
          redirect_to repository_path(resource_repository), notice: t('.fail')
        end
      end

      def set_cached_check
        @check = Rails.cache.fetch("#{params[:id]}/check", expires_in: 1.day) do
          resource_repository.checks.includes(%i[files problems]).find_by(id: params[:id])
        end
      end
    end
  end
end
