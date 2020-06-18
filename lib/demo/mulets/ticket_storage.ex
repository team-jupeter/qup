defmodule Demo.Mulets.TicketStorage do
    use Ecto.Schema
    import Ecto.Changeset

    @primary_key {:id, :binary_id, autogenerate: true}
    schema "ticket_storages" do
        field :new_payload, :binary
        field :payload_history, {:array, :binary_id}, default: []

        belongs_to :mulet, Demo.Mulets.Mulet, type: :binary_id
    
        timestamps()
    end
   
    @fields [:new_payload, :payload_history]
  
      @doc false
    def changeset(new_payload, attrs \\ %{}) do
        new_payload
      |> cast(attrs, @fields)
      |> validate_required([])
      |> archive_new_payload(attrs.new_payload)
    end
  
    defp archive_new_payload(ts_cs, new_payload) do #? ts_cs == ticket_storage changeset
        # IO.inspect new_payload
        %Demo.Mulets.TicketStorage{payload_history: [new_payload | ts_cs.data.payload_history]}
      end
  end
  