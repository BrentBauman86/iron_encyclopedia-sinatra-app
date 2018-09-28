class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :name
      t.string :muscle_group
      t.integer :rep_range
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
