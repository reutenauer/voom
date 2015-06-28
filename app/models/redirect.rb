class Redirect < ActiveRecord::Base
  # attr_accessible :source, :target, :name, :stakeholder
  belongs_to :heading
  belongs_to :type
end
