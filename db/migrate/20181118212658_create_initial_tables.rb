class CreateInitialTables < ActiveRecord::Migration[5.2]
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :data_source
      t.string :data_source_id
      t.string :data_source_url
      t.string :slug
      t.string :phone
      t.float :rating
      t.integer :total_reviews
      t.string :categories
      t.string :parent_category
      t.integer :price
      t.string :image_url
      t.timestamps
    end

    create_table :addresses do |t|
      t.string :display_address
      t.string :city
      t.string :neighborhood
      t.float :latitude
      t.float :longitude
      t.string :map_url
      t.string :cross_street
      t.references :addressable, polymorphic: true, index: true
      t.timestamps
    end

    create_table :reviews do |t|
      t.integer :business_id
      t.integer :rating
      t.string :review
      t.string :review_url
      t.timestamps
    end

    create_table :gift_cards do |t|
      t.integer :business_id
      t.boolean :active
      t.timestamps
    end
  end
end
