Rails.application.routes.draw do
  get "/", to: "graph_api#index"
  post "/retrieve-posts", to: "graph_api#retrieved_posts"

end
