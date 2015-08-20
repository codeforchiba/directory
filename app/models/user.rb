class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :authentications, dependent: :destroy, autosave: true

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true

  def has_external?
    self.authentications.exists?
  end

  def with_facebook?
    self.facebook.present?
  end

  def facebook
    if self.authentications.exists?
      self.authentications.where(provider: "facebook").first
    else
      nil
    end
  end
end
