class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|

      t.text :content
      t.references :article
      t.integer :commenter_id

      t.timestamps null: false
    end
  end
end
