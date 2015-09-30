class RedirectsController < ApplicationController
  def new
    @redirect = Redirect.new
  end

  def create
    @redirect = Redirect.new(params[:redirect].permit(:source, :target, :name, :stakeholder).merge({ heading: Heading.find_by_title("added by the Voom"), type: Type.find_by_status_code(301) }))
    @already_exists = Redirect.find_by_source(@redirect.source)
    @branch_name = Branch.new.add_vanity_url(@redirect)
  end

  def index
    @redirects = Redirect.group(:heading)
  end

  def update
    @redirect = Redirect.find(params[:id])
    @redirect.update!(target: params[:target])
    @branch_name = Branch.new.add_vanity_url(@redirect)
  end
end
