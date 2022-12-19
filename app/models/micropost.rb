class Micropost < ApplicationRecord
  # List of validation helpers can be found here: 
  # https://guides.rubyonrails.org/active_record_validations.html#validation-helpers
  validates :content, length: { maximum: 140 }
  
  belongs_to :user
end
