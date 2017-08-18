class Post < ApplicationRecord
    has_and_belongs_to_many :tags
    belongs_to :user
    has_many :likes
    has_many :liked_users, through: :likes, source: :user
    has_many :comments
    after_create do
        post = Post.find_by(id: self.id)
        hashtags = self.content.scan(/#\w+/)
        hashtags.uniq.map do |hashtag|
            tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
            post.tags << tag
        end
    end
    
    before_update do
        post = Post.find_by(id: self.id)
        post.tags.clear #we delete all and add again
        hashtags = self.content.scan(/#\w+/)
        hashtags.uniq.map do |hashtag|
            tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
            post.tags << tag
        end
    end
    
    mount_uploader :image, PostImageUploader
    
    def self.search(search)
         where("name LIKE ?", "%#{search}%")
        where(["content LIKE ?", "%#{search}%"]) 
    end    
    
    def self.search2(search,search2)
        where("name LIKE ?", "%#{search}%")
        where(["content LIKE ? OR content LIKE ?", "%#{search}%", "%#{search2}%"]) 
    end
    
    def self.search3(search,search2,search3)
        where("name LIKE ?", "%#{search}%")
        where(["content LIKE ? OR content LIKE ? OR content LIKE ?", "%#{search}%", "%#{search2}%" , "%#{search3}%"])
    end
    
    def self.search4(search,search2,search3,search4)
        where("name LIKE ?", "%#{search}%")
        where(["content LIKE ? OR content LIKE ? OR content LIKE ? OR content LIKE ?", "%#{search}%", "%#{search2}%" , "%#{search3}%" , "%#{search4}%"])
    end
    
    def self.search5(search,search2,search3,search4,search5)
        where("name LIKE ?", "%#{search}%")
        where(["content LIKE ? OR content LIKE ? OR content LIKE ? OR content LIKE ? OR content LIKE ?", "%#{search}%", "%#{search2}%" , "%#{search3}%" , "%#{search4}%" , "%#{search5}%"])
    end
end
