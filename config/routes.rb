Gridhook::Engine.routes.draw do
  post Gridhook.configuration.event_receive_path => 'events#create'
end
