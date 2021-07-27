class CreateFollowings < ActiveRecord::Migration[6.1]
  def change
    create_table :followings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :following, index: true
      t.timestamps
    end
    add_foreign_key :followings, :users, column: :following_id
  end
end
