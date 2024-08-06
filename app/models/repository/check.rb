# frozen_string_literal: true

class Repository::Check < ApplicationRecord
  include AASM

  belongs_to :repository
  has_many :files, dependent: :destroy
  has_many :problems, dependent: :destroy

  aasm column: :state do
    state :created, initial: true
    state :in_progress, :finished, :failed

    event :start do
      transitions from: :created, to: :in_progress
    end

    event :finish do
      transitions from: :in_progress, to: :finished
    end

    event :fail do
      transitions from: :in_progress, to: :failed
    end
  end

  scope :latest, -> { order(created_at: :desc) }
end
