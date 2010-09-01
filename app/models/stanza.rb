class Stanza < ActiveRecord::Base

  has_friendly_id :title, :use_slug => true, :max_length => 5
  belongs_to :user

  validates_presence_of :user
  validates_presence_of :title, :body
  validates_length_of :title, :within => 1..100
  validates_length_of :copyright_notice, :maximum => 200, :allow_nil => true
  validates_length_of :body, :within => 10..65535 # SQL 'TEXT' type
  
  named_scope :public, :conditions => { :public => true }
  named_scope :published, :conditions => ['published_at <= ?', Time.zone.now]
  named_scope :most_recent, lambda { |limit| { :order => 'published_at DESC', :limit => limit, :include => [:user] } }
  named_scope :by_user, lambda { |user| { :conditions => { :user_id => user.id } } }
  named_scope :order, lambda { |order| { :order => order } }
  
  def publish!
    self.update_attributes(:published_at => Time.zone.now)
  end

  def published?
    !self.published_at.nil? && self.published_at <= Time.zone.now
  end
  
end
