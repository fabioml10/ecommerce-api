# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  include LikeSearchable
  include Paginatable

  has_many :wish_items
  has_many :orders

  validates :name, presence: true
  validates :profile, presence: true

  enum profile: { admin: 0, client: 1 }
end
