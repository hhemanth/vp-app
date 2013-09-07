class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :dept_id
      t.string :dept_name

      t.timestamps
    end
  end
end
