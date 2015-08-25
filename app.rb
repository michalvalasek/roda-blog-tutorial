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
  DB = Sequel.connect(adapter:"postgres", database:"roda_tutorial_dev", host:"127.0.0.1", user:"michal", password:"")

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

    r.get "login" do
      view "login"
    end

    r.post "login" do
      if user = User.authenticate(r["email"],r["password"])
        session[:user_id] = user.id
        r.redirect "/"
      else
        r.redirect "/login"
      end
    end

    r.post "logout" do
      session.clear
      r.redirect "/"
    end

    r.on "users" do
      r.get "new" do
        @user = User.new
        view "users/new"
      end

      r.get ":id" do |id|
        @user = User[id]
        view "users/show"
      end

      r.is do
        r.get do
          @users = User.order(:id)
          view "users/index"
        end

        r.post do
          @user = User.new(r["user"])
          if @user.valid? && user.save
            r.redirect "/users"
          else
            view "users/new"
          end
        end
      end
    end
  end
end
