class AddIpAddressToMoveRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :move_requests, :ip_address, :string
  end
end
