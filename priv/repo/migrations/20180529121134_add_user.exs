defmodule Discuss.Repo.Migrations.AddUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :code, :string
      add :provider, :string
    end
  end
end
