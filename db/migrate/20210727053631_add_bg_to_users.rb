class AddBgToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :bg_img, :string
  end
end
