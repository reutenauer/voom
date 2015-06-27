class AddHeadingToRedirect < ActiveRecord::Migration
  def change
    change_table :redirects do |t|
      t.string :heading
    end
  end
end
