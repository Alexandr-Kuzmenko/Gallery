Recaptcha.configure do |config|
  # local
  config.site_key  = '6Ldic3kUAAAAAOjUG3oaq3qvpD9f05G_oSy8zmwO' if Rails.env.development?
  config.secret_key = '6Ldic3kUAAAAAB06X_42pEp_veOVlsLvROQSOrHh' if Rails.env.development?
  # prod on heroku
  config.site_key = '6LcesIYUAAAAAL_Y4heytptdTn21sqrjLqoKMEND' if Rails.env.production?
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
end