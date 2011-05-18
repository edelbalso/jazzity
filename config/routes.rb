Jazzity::Application.routes.draw do
  
  ActiveAdmin.routes(self)

  resources :searches
  
  resources :keys do
    resources :tunes
    resources :chord_qualities
    resources :chords
    resources :voicings
    resources :progressions
    resources :notes_collections, :path => "notes"
    resources :scales do
      resources :modes
    end
  end
  
  resources :tunes
  resources :musicians
  resources :chord_qualities
  resources :chords
  resources :scales do
    resources :modes
  end

  resources :voicings
  resources :progressions
  resources :concepts
  resources :notes_collections, :path => "notes"
  
  root :to => "dashboards#show"
  
end
