class CreateRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :relations do |t|
      t.references :user, foreign_key: {on_delete: :cascade}, index: true
      t.references :target_user, foreign_key: {on_delete: :cascade, to_table: :users}, index: true
      t.boolean :friend
      t.boolean :subscribe
      t.boolean :block

      t.timestamps
    end

    add_index :relations, :friend
    add_index :relations, :subscribe
    add_index :relations, :block
  end
end
