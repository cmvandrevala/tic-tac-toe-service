class AddReturnedMoveToMoveRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :move_requests, :returned_move, :string
  end
end
