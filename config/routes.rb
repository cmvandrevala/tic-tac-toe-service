Rails.application.routes.draw do
  root to: 'computer_players#computer_move'
  get 'api/computer_move', to: 'computer_players#computer_move'
  get 'api/running_log', to: 'statistics#running_log'
end
