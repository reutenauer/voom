class Redirect < ActiveRecord::Base
  # attr_accessible :source, :target
  belongs_to :heading
end
