class Meetup < ActiveRecord::Base
  validates :name, presence: true
  validates :name, length: { maximum: 50 }
  validates :location, presence: true
  validates :description, presence: true
  validates :description, length: { maximum: 140 }

  has_many :usermeetups
  has_many :users, through: :usermeetups
end
