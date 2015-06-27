class AddTypeToRedirects < ActiveRecord::Migration
  def change
    change_table :redirects do |t|
      t.references :type
    end
  end
end
