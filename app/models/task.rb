class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 60 }
  
  belongs_to :user
end
