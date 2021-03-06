class AddTagsAndRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :name
      t.timestamps
    end

    create_table :meals_tags, id: false do |t|
      t.belongs_to :meal, index: true
      t.belongs_to :tag, index: true
    end
  end
end
