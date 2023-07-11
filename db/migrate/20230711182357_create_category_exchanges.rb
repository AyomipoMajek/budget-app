class CreateCategoryExchanges < ActiveRecord::Migration[7.0]
  def change
    create_table :category_exchanges do |t|
      t.references :exchange, index: true, null: true, foreign_key:{to_table: :exchanges}
      t.references :category, index: true, null: true, foreign_key:{to_table: :categories}
      t.timestamps
    end
  end
end