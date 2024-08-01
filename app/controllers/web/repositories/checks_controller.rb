# frozen_string_literal: true

module Web
  module Repositories
    class ChecksController < ApplicationController
      def show
        @check = resource_repository.checks.find params[:id]
      end

      def create
        @check = resource_repository.checks.build

        if @check.save
          CheckReposJob.perform_later(@check.id)

          redirect_to repository_path(resource_repository), notice: t('.success')
        else
          redirect_to repository_path(resource_repository), notice: t('.fail')
        end
      end
    end
  end
end
