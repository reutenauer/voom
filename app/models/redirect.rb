class Redirect < ActiveRecord::Base
  # attr_accessible :source, :target
  belongs_to :heading
  belongs_to :type
end
