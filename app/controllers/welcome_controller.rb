class WelcomeController < ApplicationController

  def index
    @stanzas = Stanza.public.published
  end

end
