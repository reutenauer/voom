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
    # Redirect.all
    @redirects = { }
    @count = 0
    Heading.order(:id).each do |heading|
      @redirects[heading] = Redirect.where(heading: heading).order(:name)
      @count += @redirects[heading].count
    end
    # @count = @redirects.inject { |sum, head, redirs| sum + redirs.count }
  end

  def update
    @redirect = Redirect.find(params[:id])
    @redirect.update!(target: params[:target])
    @branch_name = Branch.new.add_vanity_url(@redirect)
  end
end
