defmodule Demo.Mulets.Payload do
    use Ecto.Schema
    import Ecto.Changeset
    alias Demo.Mulets.Payload

    @primary_key {:id, :binary_id, autogenerate: true}
    schema "payloads" do
        field :data, :string
        field :payload_hash, :string

        belongs_to :supul, Demo.Supuls.Supul, type: :binary_id
    
        timestamps()
    end
   
    @fields [:data, :payload_hash] 
  
      @doc false
    def changeset(%Payload{} = payload, attrs \\ %{}) do
      payload
      |> cast(attrs, @fields)
      |> validate_required([])
      # |> put_payload_hash()
    end

  defp put_payload_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{data: payload}} ->
        payload_hash = Pbkdf2.hash_pwd_salt(payload)
        put_change(changeset, :payload_hash, payload_hash)

      _ ->
        changeset
    end
  end
end
  