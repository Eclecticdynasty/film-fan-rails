class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email
  has_many :comments
  has_many :movies
  has_many :commented_movies, through: :comments, source: :movie
  has_one :directory
end
