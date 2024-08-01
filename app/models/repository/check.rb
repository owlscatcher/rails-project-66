# frozen_string_literal: true

class Repository::Check < ApplicationRecord
  include AASM

  belongs_to :repository

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
end
