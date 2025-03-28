class User < ApplicationRecord
  validates :fullname, :email, :uuid, presence: true
end
