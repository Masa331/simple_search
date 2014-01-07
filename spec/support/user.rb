class User < ActiveRecord::Base

  extend SimpleSearch::ModelAdditions

  scope :name_search, -> (name) { where('first_name = ? or last_name = ?', name, name) }

  searchables :first_name, :last_name, :age
  search_methods :name_search

end
