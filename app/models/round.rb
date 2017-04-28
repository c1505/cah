class Round < ApplicationRecord
  belongs_to :host, class_name: 'User', foreign_key: 'user_id'
end
# belongs_to :writer, class_name: 'Author', foreign_key: 'author_id'
