class AddRouteToMoveRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :move_requests, :route, :string
  end
end
