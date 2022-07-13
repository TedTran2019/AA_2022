class StaticPagesController < ApplicationController
  before_action :require_logged_in, only: %i[root]
  
  def root
  end
end
