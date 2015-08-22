class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :authentications, dependent: :destroy, autosave: true

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, email: true

  attr_accessor :current_password

  before_create :initialize_uuid

  with_options on: :with_password do |v|
    v.validates :password, presence: true, confirmation: true, length: { minimum: 8 }
    v.validates :password_confirmation, presence: true
  end

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

  private

  def initialize_uuid
    self.uuid = SecureRandom.uuid
  end
end
