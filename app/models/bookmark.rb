class Bookmark < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  validates :user, presence: true
end
