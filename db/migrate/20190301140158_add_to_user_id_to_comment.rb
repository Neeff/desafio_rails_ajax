class AddToUserIdToComment < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :userclear, :string
  end
end
