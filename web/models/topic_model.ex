defmodule Discuss.Topic do
  use Discuss.Web, :model

  schema "topics" do
    field :title, :string
  end

  def changeset(record, params \\ %{}) do
    record
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end