class CreateDuties < ActiveRecord::Migration[5.2]
  def change
    create_table :duties do |t|
      t.references :member, null: false # 外部キー
      t.string :role , null: false # 役割
      t.timestamps
    end
  end
end
