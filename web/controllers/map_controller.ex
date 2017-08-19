defmodule Emporium.MapController do
  use Emporium.Web, :controller

  alias Emporium.Map

  plug EnsureAuthenticated, handler: __MODULE__, typ: "token"

  def index(conn, _params, current_user, _claims) do
    map = %{
      src_lat: 50.363872,
      src_long: 30.927386,
      dst_lat: 50.361836,
      dst_long: 30.927912,
      zoom: 15
    }
    render(conn, "index.html", map: map, current_user: current_user)
  end

  def places(conn, _params, current_user, _claims) do
    render(conn, "places.html", current_user: current_user)
  end

  def map(conn, _params, current_user, _claims) do
    render(conn, "places.html", current_user: current_user)
  end

end
