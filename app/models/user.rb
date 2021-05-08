class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :posts, dependent: :destroy
         has_many :comments, dependent: :destroy
         has_many :favorites, dependent: :destroy
         has_many :relationships, dependent: :destroy
         has_many :followings, through: :relationships, source: :follow
         has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
         has_many :followers, through: :reverse_of_relationships, source: :user
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

          def follow(other_user)
            unless self == other_user
              self.relationships.find_or_create_by(follow_id: other_user.id)
            end
          end

          def unfollow(other_user)
            relationship = self.relationships.find_by(follow_id: other_user.id)
            relationship.destroy if relationship
          end

          def following?(other_user)
            self.followings.include?(other_user)
          end
end
