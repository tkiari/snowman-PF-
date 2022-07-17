class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_one_attached :image
  has_one_attached :post_image
  
  #いいね機能
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  #画像
  def get_post_image(width,height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/post.jpg')
      post_image.attach(io:File.open(file_path),filename:'default-image.jpg',content_type:'image/jpeg')
    end
    post_image.variant(resize_to_limit: [width,height]).processed
  end
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("title LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end
  
end
