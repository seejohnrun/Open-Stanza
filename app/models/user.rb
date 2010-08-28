class User < ActiveRecord::Base

  has_many :stanzas
  has_friendly_id :short_name, :use_slug => false, :allow_nil => true # users don't have to have names

  validates_length_of :short_name, :maximum => 50, :allow_nil => true
  validates_uniqueness_of :short_name

  def most_recent_stanzas
    Stanza.by_user(self).published.most_recent(limit)
  end
  
  def public_name
    display_name || short_name || email.split('@')[0] || "User #{self.id}"
  end
  
end
