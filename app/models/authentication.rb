class Authentication < ActiveRecord::Base

  validates :uid, presence: true, uniqueness: { scope: :provider }
end
