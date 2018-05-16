class HomeController < ApplicationController
  def index
		@polls = Poll.current
  end
end
