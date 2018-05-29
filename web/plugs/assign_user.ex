defmodule Discuss.Plug.AssignUser do
  import Plug.Conn

  alias Discuss.Repo
  alias Discuss.User

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    case get_session(conn, :user_id) do
      nil -> assign(conn, :user, nil)
      user_id -> assign(conn, :user, Repo.get(User, user_id))
    end
  end
end
  