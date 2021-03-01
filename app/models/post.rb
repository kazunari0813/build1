class Post < ApplicationRecord

	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	attachment :image

	validates :title, presence: :true, length: {maximum: 30}
	validates :body, :image, presence: :true

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

end
