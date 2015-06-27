class AddRedirectTable < ActiveRecord::Migration
  def change
    create_table :redirects do |t|
      t.string :source
      t.string :target

      t.timestamps null: false
    end
  end
end
