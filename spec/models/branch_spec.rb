require 'spec_helper'

describe Branch do
  describe ".create" do
    # TODO
    # it "checks out the git repository" do
    #   expect do
    #     Branch.create
    #   end.to_receive
    # end

    it "works" do
      redirect = Redirect.new(source: "/flyingpigs", target: "http://www.roh.org.uk/productions/the-flying-pigs-by-ebenezer-scrooge", name: "My name", stakeholder: "The Big Cheese", heading: Heading.find_by_title("added by the Voom"), type: Type.find_by_status_code(301))
      Branch.add_vanity_url(redirect)
    end
  end
end
