require "roda"

class App < Roda
  plugin :static, ["/images", "/css", "/js"]
  plugin :render
  plugin :head

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
