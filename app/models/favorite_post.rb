class CreateFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :post
end
