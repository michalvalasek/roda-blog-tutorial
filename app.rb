require "roda"
require "sequel"
require "bcrypt"
require "rack/protection"

class App < Roda
  plugin :static, ["/images", "/css", "/js"]
  plugin :render
  plugin :head

  Sequel::Model.plugin :validation_helpers

  # DB initialization
  DB = Sequel.connect(adapter:"postgres", database:"roda_tutorial_dev", host:"127.0.0.1", user:"", password:"")

  # security
  use Rack::Session::Cookie, secret: "someNice_long_r4nd0mString_coi43j2cm(>Cd)42Nc", key: "_roda_tutorial_session"
  use Rack::Protection
  plugin :csrf

  # models
  require './models/user.rb'

  route do |r|
    r.root do
      view "homepage"
    end

    r.get "about" do
      view "about"
    end

    r.get "contact" do
      view "contact"
    end
  end
end
