class Stanza < ActiveRecord::Base

  has_friendly_id :title, :use_slug => true, :max_length => 5
  belongs_to :user

  validates_presence_of :user
  validates_length_of :copyright_notice, :maximum => 200
  
  named_scope :public, :conditions => { :public => true }
  named_scope :published, :conditions => ['published_at < ?', Time.zone.now]
  named_scope :most_recent, lambda { |limit| { :order => 'published_at DESC', :limit => limit, :include => [:user] } }
  named_scope :by_user, lambda { |user| { :conditions => { :user_id => user.id } } }
  
  def publish!
    self.update_attributes(:published_at => Time.zone.now)
  end
  
end
