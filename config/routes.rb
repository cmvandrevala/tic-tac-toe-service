Rails.application.routes.draw do
  get 'api/computer_move', to: 'computer_players#computer_move'
  get 'api/endpoints_hit', to: 'statistics#endpoints_hit'
end
