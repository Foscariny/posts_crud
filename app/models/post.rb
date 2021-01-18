class Post < ApplicationRecord

    belongs_to :user
    
    scope :bad, ->{ where('rating <= ?', 3) }
    scope :good, ->{ where('rating > ?', 3) }
    scope :your_ratings,-> (test) { where('user_id = ?', test) }
end
