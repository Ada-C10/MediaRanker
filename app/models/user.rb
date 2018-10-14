class User < ApplicationRecord
has_many :works
has_many :votes
<<<<<<< HEAD

=======
>>>>>>> voting
validates :user_name, :id, presence: true


end
