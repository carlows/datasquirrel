Jets.application.routes.draw do
  post 'groups', to: 'groups#create'

  post 'groups/:name/count/increment', to: 'counts#increment'
  post 'groups/:name/gauge/emit', to: 'gauges#emit'

  get 'groups/:name/count', to: 'counts#count'

  # root "jets/public#show"

  # # The jets/public#show controller can serve static utf8 content out of the public folder.
  # # Note, as part of the deploy process Jets uploads files in the public folder to s3
  # # and serves them out of s3 directly. S3 is well suited to serve static assets.
  # # More info here: https://rubyonjets.com/docs/extras/assets-serving/
  # any "*catchall", to: "jets/public#show"
end
