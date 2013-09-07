class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :course_id
      t.string :disciplineId
      t.string :course_type
      t.boolean :under_development
      t.string :syllabus_link
      t.string :course_link
      t.boolean :already_processed
      t.string :processed_in
      t.boolean :under_review
      t.string :has_ppt
      t.timestamps
    end
  end
end
