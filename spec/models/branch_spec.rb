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
      Branch.add_vanity_url("/flyingpigs", "http://www.roh.org.uk/productions/the-flying-pigs-by-ebenezer-scrooge")
    end
  end
end
