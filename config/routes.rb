Rails.application.routes.draw do
  post '/sums' =>'tasks#sums'
  post '/filters' =>'tasks#filters'
  post '/intervals' =>'tasks#intervals'
  post '/lin_regressions' =>'tasks#lin_regressions'
end
