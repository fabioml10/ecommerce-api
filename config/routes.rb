Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/emails" if Rails.env.development?
end
