class Episode < ActiveRecord::Base
  belongs_to :show
  has_and_belongs_to_many :users
end
