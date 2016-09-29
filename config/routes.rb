Gridhook::Engine.routes.draw do
  post Gridhook.configuration.event_receive_path => 'gridhook/events#create'
end
