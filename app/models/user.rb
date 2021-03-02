class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :posts, dependent: :destroy
         has_many :comments, dependent: :destroy
         has_many :favorites, dependent: :destroy
         attachment :profile_image

          validates :name, presence: true
          validates :email, presence: true

          def User.search(search, user_or_post)
            if user_or_post == "1"
              User.where(['name LIKE ?', "%#{search}%"])
            else
              User.all
            end
          end
end
