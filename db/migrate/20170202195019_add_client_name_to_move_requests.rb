class AddClientNameToMoveRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :move_requests, :client_name, :string
  end
end
