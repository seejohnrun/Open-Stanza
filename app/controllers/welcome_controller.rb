class WelcomeController < ApplicationController

  def index
    @most_recent_stanzas = Stanza.public.published.most_recent(10)
  end

end
