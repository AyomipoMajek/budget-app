class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.references :author, index: true, nil: true, foreign_key:{to_table: :users}
      t.string :name 
      t.timestamps
    end
  end
end