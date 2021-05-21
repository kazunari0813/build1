class Post < ApplicationRecord

	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy

	attachment :image

	validates :title, presence: true, length: {maximum: 30}
	validates :body, :image, presence: true
	validates :rate, numericality: {
		less_than_or_equal_to: 5,
		greater_than_or_equal_to: 1}, presence: true

		def favorited_by?(user)
			favorites.where(user_id: user.id).exists?
		end

		def Post.search(search, user_or_post)
			if user_or_post == "2"
				Post.where(['title LIKE ?', "%#{search}%"])
			else
				Post.all
			end
		end

end
