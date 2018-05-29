defmodule Discuss.Plug.AuthRequired do
  import Plug.Conn
  import Phoenix.Controller
  import Discuss.Router.Helpers

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    case conn.assigns[:user] do
      nil ->
        conn
        |> redirect(to: topic_path(conn, :index))
        |> halt()
      _ -> conn
    end
  end
end
