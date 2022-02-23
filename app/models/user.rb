class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  # ＝＝＝＝＝＝＝＝＝＝＝＝＝自分がフォローしているユーザーとの関連＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # Relationshipモデル参照からfollower_id（フォローする側）カラム指定。
  # フォローする側のUserから見て、フォローされる側のUserを集める。
  has_many :followings, through: :relationships, source: :followed
  # Relationshipモデル参照しfollowed（フォローされた側）のユーザー情報を集めることを「followings」と定義
　#＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝ 　


  # ＝＝＝＝＝＝＝＝＝＝＝＝＝自分がフォローされるユーザーとの関連＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # Relationshipモデル参照からfollowed_id（フォローされる側）カラム指定。
  # フォローされる側のUserから見て、フォローしてくる側のUserを集める。
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # Relationshipモデル参照しfollower（フォローする側）のユーザー情報を集めることを「followers」と定義
  #＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝ 　
  
    
    
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
