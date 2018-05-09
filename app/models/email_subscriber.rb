class EmailSubscriber < ActiveRecord::Base
  validates :email, presence: true
end
