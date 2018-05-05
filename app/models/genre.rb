class Genre < ApplicationRecord
has_many :movies

  before_validation :make_title_case
  validates :name, presence: true, uniqueness: true

  def make_title_case
    self.name = self.name.titlecase
  end
  
end
