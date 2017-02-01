Rails.application.routes.draw do
  root to: 'computer_players#get_move'
  get 'api/get_move', to: 'computer_players#get_move'
  get 'api/get_statistics', to: 'statistics#get_statistics'
end
