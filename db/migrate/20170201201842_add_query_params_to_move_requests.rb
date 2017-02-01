class AddQueryParamsToMoveRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :move_requests, :query_params, :string
  end
end
