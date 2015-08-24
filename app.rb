require "roda"
require "sequel"

class App < Roda
  plugin :static, ["/images", "/css", "/js"]
  plugin :render
  plugin :head

  # DB initialization
  DB = Sequel.connect(adapter:"postgres", database:"roda_tutorial_dev", host:"127.0.0.1", user:"", password:"")

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
