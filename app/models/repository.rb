# frozen_string_literal: true

# == Schema Information
#
# Table name: repositories
#
#  id         :integer          not null, primary key
#  name       :string
#  github_id  :integer          not null
#  full_name  :string
#  language   :string
#  clone_url  :string
#  ssh_url    :string
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Repository < ApplicationRecord
  extend Enumerize

  belongs_to :user
  has_many :checks, dependent: :destroy

  enumerize :language, in: %i[ruby javascript]

  validates :github_id, presence: true, uniqueness: true

  scope :latest, -> { order(created_at: :desc) }
end
