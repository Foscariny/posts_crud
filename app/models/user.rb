class User < ApplicationRecord

    has_many :posts
    has_secure_password

    validates :username, presence: true
    validates :password, presence: true
end
