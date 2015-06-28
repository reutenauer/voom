class UrlsController < ApplicationController
  def new
  end

  def create
    @source = params['url']['source']
    @target = params['url']['target']
    @name = params['url']['name']
    @stakeholder = params['url']['stakeholder']
  end
end
