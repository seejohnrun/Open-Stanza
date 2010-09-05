class Stanza < ActiveRecord::Base

  has_friendly_id :title, :use_slug => true, :max_length => 5
  belongs_to :user
  has_many :comments, :dependent => :destroy

  accepts_nested_attributes_for :comments
  
  validates_presence_of :user
  validates_length_of :title, :within => 1..100
  validates_length_of :copyright_notice, :maximum => 200, :allow_nil => true
  validates_length_of :body, :within => 10..65535 # SQL 'TEXT' type

  attr_protected :user_id, :created_at, :updated_at, :cached_slug, :published_at
  
  named_scope :public, :conditions => { :public => true }
  named_scope :published, :conditions => ['published_at <= ?', Time.zone.now]
  named_scope :most_recent, { :order => 'published_at DESC', :include => [:user] }
  named_scope :most_comments, { :order => '(select count(1) as comment_count from comments where stanza_id = stanzas.`id`) DESC', :include => [:user] }
  named_scope :most_comments_since, lambda { |date| { :order => "(select count(1) as comment_count from comments where stanza_id = stanzas.id and stanzas.created_at >= '#{date.to_s(:db)}') DESC", :include => [:user] } }
  named_scope :by_user, lambda { |user| { :conditions => { :user_id => user.id } } }
  named_scope :order, lambda { |order| { :order => order } }
  named_scope :limit, lambda { |limit| { :limit => limit } }
  named_scope :exclude, lambda { |stanza| { :conditions => ['id != ?', stanza] } }
  
  def publish!
    self.update_attributes(:published_at => Time.zone.now)
  end

  def published?
    !self.published_at.nil? && self.published_at <= Time.zone.now
  end
  
end
