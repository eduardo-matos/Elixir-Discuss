defmodule Discuss.AuthController do
  use Discuss.Web, :controller
  plug Ueberauth
  alias Discuss.User

  def callback(conn, %{"code" => code}) do
    user_params = %{
      email: conn.assigns.ueberauth_auth.info.email,
      code: code,
      provider: to_string(conn.assigns.ueberauth_auth.provider),
    }

    case get_or_create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "User successfully found!")
        |> redirect(to: topic_path(conn, :index))
      {:error, reason} ->
        conn
        |> put_flash(:error, "Some error occurred: #{reason}")
        |> redirect(to: topic_path(conn, :index))
    end
  end

  def logout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: topic_path(conn, :index))
  end

  defp get_or_create_user(user_params) do
    case Repo.get_by(User, email: user_params.email) do
      nil -> create_user(user_params)
      user -> {:ok, user}
    end
  end

  defp create_user(user_params) do
    changeset = User.changeset(%User{}, %{
      email: user_params.email,
      code: user_params.code,
      provider: user_params.provider,
    })

    Repo.insert(changeset)
  end
end
