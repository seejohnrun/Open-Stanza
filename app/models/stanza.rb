class Stanza < ActiveRecord::Base

  has_friendly_id :title, :use_slug => true

  named_scope :public, :conditions => { :public => true }
  named_scope :published, :conditions => ['published_at < ?', Time.zone.now]
  named_scope :most_recent, lambda { |limit| { :order => 'published_at DESC', :limit => limit } }
  
end
