class User < ActiveRecord::Base

  has_many :stanzas, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_friendly_id :short_name, :use_slug => false, :allow_nil => true # users don't have to have names

  acts_as_authentic

  validates_length_of :display_name, :within => 4..50, :allow_nil => true, :allow_blank => true
  validates_length_of :short_name, :maximum => 50, :allow_nil => true
  validates_length_of :biography, :within => 5..5000, :allow_nil => true
  validates_uniqueness_of :short_name, :allow_nil => true

  attr_accessible :display_name, :email, :short_name, :biography, :password, :password_confirmation
  
  def most_recent_stanzas
    Stanza.by_user(self).published.most_recent(limit)
  end
  
  def public_name
    display_name || short_name || email.split('@')[0] || "User #{self.id}"
  end
  
end
