Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env == 'development'
      provider :facebook, '160533327440926', '6cf229e15224840ec23094ae1d6f017d'
  else
      provider :facebook, '525510040818134', 'ecd6d048153c73b22a7a5a378c4f9292'
  end

  provider :linkedin, 'dojdx5qwh26u', 'aU6rxgAPWRSiRKBT'
  provider :twitter, 'EYHZFbVeEVczRXvFoOwQA', 'MSIyPe5lGpoL2RSMxwv3TqQFKHgKYgdBCRSzBxvsFs'
  provider :google_oauth2, '771587125701.apps.googleusercontent.com', 'XPSLHOv8mGi-Mw4cTuvBcM9o'
end