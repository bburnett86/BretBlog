class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|

      t.string :title
      t.text :content
      t.boolean :about_me, default: false
      t.boolean :project, default: false
      t.boolean :blog_post, default: false
      t.string :pic_url
      t.references :user

      t.timestamps null: false
    end
  end
end
