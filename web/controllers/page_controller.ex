defmodule Emporium.PageController do
  use Emporium.Web, :controller

  plug :put_layout, "splash.html"
  plug EnsureAuthenticated, handler: __MODULE__, typ: "token"

   def index(conn, _params, current_user, _claims) do
     render conn, "index.html", current_user: current_user
   end

   def unauthenticated(conn, _params) do
     conn
     |> put_flash(:error, "Authentication required")
     |> redirect(to: auth_path(conn, :login, :identity))
   end
end
