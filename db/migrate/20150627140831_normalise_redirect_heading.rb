class NormaliseRedirectHeading < ActiveRecord::Migration
  def change
    remove_column :redirects, :heading, :string

    change_table :redirects do |t|
      t.references :heading
    end

    create_table :headings do |t|
      t.string :title
      t.integer :rank

      t.timestamps null: false
    end
  end
end
