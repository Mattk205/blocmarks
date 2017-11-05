class Topic < ApplicationRecord
  belongs_to :user
  has_many :bookmarks
  validates :user, presence: true

end
