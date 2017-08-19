defmodule Emporium.Router do
  use Emporium.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  scope "/", Emporium do
    pipe_through [:browser, :browser_auth] # Use the default browser stack

    get     "/",                          PageController,              :index
    delete  "/logout",                    AuthController,              :logout
    get     "/credentials",               AuthController,              :credentials
    get     "/signup",                    SignupController,            :new
    get     "/maps",                      MapController,               :index
    get     "/places",                    MapController,               :places
    get     "/admin/users",               UserController,              :index
    get     "/users/resume",              UserController,              :resume
    get     "/admin/users/:id/manage",    UserController,              :manage
    patch   "/admin/users/:id",           UserController,              :update
    put     "/admin/users/:id",           UserController,              :update
    post    "/admin/users/:id",           UserController,              :update
    post    "/admin/users/:id/role",      UserController,              :insert_ur
    delete  "/admin/users/:id/role/:role_id",  UserController,         :delete_ur
    resources "/admin/roles",             RoleController

    resources "/parts", PartController

    #resources "/admin/products", Backend.ProductController
  end

  scope "/auth", Emporium do
    pipe_through [:browser, :browser_auth] # Use the default browser stack

    get "/:identity",           AuthController, :login
    get "/:identity/callback",  AuthController, :callback
    post "/:identity/callback", AuthController, :callback
  end
  # Other scopes may use custom stacks.
  # scope "/api", CouchdbPhoenix do
  #   pipe_through :api
  # end
end
