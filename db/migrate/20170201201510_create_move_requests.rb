class CreateMoveRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :move_requests do |t|

      t.timestamps
    end
  end
end
