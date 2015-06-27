class DropHeadingsIdFromRedirects < ActiveRecord::Migration
  def change
    remove_column :redirects, :headings_id, :integer
  end
end
