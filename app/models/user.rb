class User < ApplicationRecord
  has_many :pictures
  has_many :favorites, dependent: :destroy

  
  
  has_secure_password
  mount_uploader :image, ImageUploader
  
end

end
