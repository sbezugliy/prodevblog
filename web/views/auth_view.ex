defmodule Emporium.AuthView do
  use Emporium.Web, :view

  def render("credentials.json", %{user: user, jwt: jwt}) do
    %{user: user, jwt: jwt}
  end

  def render("failed_credentials.json", %{error: error}) do
    %{error: error}
  end
end
