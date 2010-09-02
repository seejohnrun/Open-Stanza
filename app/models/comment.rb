class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :stanza
  
  validates_presence_of :body
  validates_presence_of :user
  validates_presence_of :stanza
  validates_length_of :body, :within => 10..5000

  attr_accessible :body

  named_scope :order, lambda { |order| { :order => order } }
  
end
