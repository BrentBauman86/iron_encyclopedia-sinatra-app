class Exercise < ActiveRecord::Base
  belongs_to :user

  validates :name, :muscle_group, :rep_range, presence: true
  validates :name, uniqueness: true
end
