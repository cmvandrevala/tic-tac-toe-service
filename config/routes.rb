Rails.application.routes.draw do
  root to: 'computer_players#get_move'
  get 'api/get_move', to: 'computer_players#get_move'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
