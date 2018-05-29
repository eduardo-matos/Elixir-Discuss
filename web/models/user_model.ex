defmodule Discuss.User do
  use Discuss.Web, :model

  schema "users" do
    field :email, :string
    field :code, :string
    field :provider, :string
  end

  def changeset(record, params \\ %{}) do
    record
    |> cast(params, [:email, :code, :provider])
    |> validate_required([:email, :code, :provider])
  end
end