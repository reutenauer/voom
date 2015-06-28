class RedirectsController < ApplicationController
  def new
    @redirect = Redirect.new
  end

  def create
    @redirect = Redirect.new(params[:redirect].permit(:source, :target, :name, :stakeholder))
  end

  def index
    @redirects = Redirect.all
  end
end
