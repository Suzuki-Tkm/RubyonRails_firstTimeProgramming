class AlterMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :alph_name, :string, null: false, default: ''
  end
end
