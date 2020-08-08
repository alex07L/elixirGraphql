defmodule ElixirGraphqlWeb.Router do
  use ElixirGraphqlWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/api", Absinthe.Plug,
      schema: ElixirGraphqlWeb.Schema.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: ElixirGraphqlWeb.Schema.Schema,
      interface: :simple
  end
end
