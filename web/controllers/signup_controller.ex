defmodule Emporium.SignupController do
  use Emporium.Web, :controller
  alias Emporium.User

  def new(conn, params, current_user, _claims) do
    render conn, "new.html", current_user: current_user
  end
end
