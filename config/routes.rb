Rails.application.routes.draw do
  match '/sums' =>'sums#sums',via: :post
end
