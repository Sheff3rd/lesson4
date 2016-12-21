class AddTasksCountToLists < ActiveRecord::Migration[5.0]
  def change
    change_table :lists do |t|
      t.integer :tasks_count, default: 0
    end

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
        UPDATE lists
           SET tasks_count = (SELECT count(1)
                                   FROM tasks
                                  WHERE tasks.list_id = lists.id)
    SQL
  end
end
