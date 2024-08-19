# frozen_string_literal: true

class RepositoryPolicy < ApplicationPolicy
  def create?
    user && record.user == user
  end

  def new?
    create?
  end

  def show?
    create?
  end
end
