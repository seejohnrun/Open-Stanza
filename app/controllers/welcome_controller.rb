class WelcomeController < ApplicationController

  def index
    @most_recent_stanzas = Stanza.public.published.most_recent.limit(10)
    @most_commented_stanzas_in_week = Stanza.public.published.most_comments_since(7.days.ago).limit(10)
  end

end
