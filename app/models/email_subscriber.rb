class EmailSubscriber < ApplicationRecord
  validates :email, presence: true
end
