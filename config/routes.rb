Rails.application.routes.draw do
  post "email-bounces/new", to: "email_bounce#new"
end
