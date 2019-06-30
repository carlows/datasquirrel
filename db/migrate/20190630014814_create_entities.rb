class CreateEntities < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.index :name, unique: true

      t.timestamps
    end

    create_table :gauges do |t|
      t.string :slug, null: false
      t.float :value, null: false
      t.belongs_to :group, index: true
      t.index :slug

      t.timestamps
    end

    create_table :counts do |t|
      t.string :slug, null: false
      t.belongs_to :group, index: true
      t.index :slug

      t.timestamps
    end
  end
end
