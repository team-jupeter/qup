defmodule Demo.Openhashes do
  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Openhashes.Openhash
  alias Demo.GlobalSupuls.GlobalSupul
  alias Demo.NationSupuls.NationSupul
  alias Demo.StateSupuls.StateSupul
  alias Demo.StateSupuls
  alias Demo.Supuls.Supul
  alias Demo.Supuls
  alias Demo.Transactions
 
  alias Demo.Weddings
  # alias Demo.Transactions 

  def list_openhashes do
    Repo.all(Openhash)
  end

  def get_openhash!(id), do: Repo.get!(Openhash, id)

  def create_openhash(attrs) do
    %Openhash{}
    |> Openhash.changeset(attrs)
    |> Repo.insert()
  end

  def update_openhash(%Openhash{} = openhash, attrs) do
    openhash
    |> Openhash.changeset(attrs)
    |> Repo.update()
  end

  def delete_openhash(%Openhash{} = openhash) do
    Repo.delete(openhash)
  end

  def change_openhash(%Openhash{} = openhash) do
    Openhash.changeset(openhash, %{})
  end

  def create_openhash(%Supul{} = supul, event) do
    IO.puts "create_openhash(supul, event)"
 
    {:ok, openhash} =
      Openhash.changeset(%Openhash{}, %{
        event_id: event.id,

        input_email: event.input_email, 
        output_email: event.output_email, 

        supul_id: supul.id,
        supul_name: supul.name,

        previous_hash: supul.previous_hash,
        incoming_hash: supul.incoming_hash,
        current_hash: supul.current_hash,
      })
      |> Repo.insert() 

    '''
        #? add supul signature to the openhash struct.  
        #? hard coding supul private key. 
        supul_rsa_priv_key = ExPublicKey.load!("./keys/hankyung_private_key.pem")

        openhash_serialized = Poison.encode!(openhash)    
        {:ok, supul_signature} = ExPublicKey.sign(ts_openhash_serialized, supul_rsa_priv_key)
        
        # openhash_hash = Pbkdf2.hash_pwd_salt(openhash_serilized)

        {:ok, openhash} = Openhash.changeset(openhash, %{supul_signature: supul_signature}) 
        |> Repo.update()
    '''

    # ? Add the new openhash to the supul's openhash array.
    Supuls.update_openhash(supul, %{openhash: openhash})  
    
    # Repo.preload(supul, :openhashes)
    # |> Supul.changeset_openhash(%{openhash: openhash})
    # |> Repo.update!()
    
    # # ? put assoc
    # Repo.preload(supul, :openhash)
    # |> Supul.changeset_openhash(%{openhash: openhash})
    # |> Repo.update!()

    # ? UPDATE OPENHASH BLOCK
    # ? add openhash_id to the openhash block of the supul.
    openhash_box = [openhash.id | supul.openhash_box]
    Supuls.update_openhash_box(supul, %{openhash_box: openhash_box})  #? will be sent to the upper supul of this supul.

    # ? add openhash to the event. 
    attrs = %{
      openhash: openhash, 
      supul_code: supul.supul_code,
      openhash_id: openhash.id
      } 

      #? Openhash is stored by both supul and by event. 
    case event.type do
      "wedding" -> Weddings.add_openhash(event, attrs)
      "transaction" -> Transactions.add_openhash(event, attrs)
      _ -> "error"  
    end

    # IO.puts("if supul.hash_count == 20")
    # if supul.hash_count == 6, do: report_openhash_box_to_upper_supul(supul)
    if supul.hash_count == 100 do
      IO.puts("report_openhash_box_to_upper_supul")

      openhash_box_serialized = Poison.encode!(supul.openhash_box)
      hash_of_openhash_box = Pbkdf2.hash_pwd_salt(openhash_box_serialized)

      state_supul = Repo.preload(supul, :state_supul).state_supul

      StateSupuls.update_state_supul(state_supul, %{
        incoming_hash: hash_of_openhash_box,
        sender: supul.id
      })

      # ? init supul for the next hash block. 
      Supul.changeset(supul, %{hash_count: 1, openhash_box: []})

    end
    
    IO.puts("Do you see me? 2 ^^*")
    
    #? return openhash
    {:ok, openhash}
  end

  def make_state_openhash(state_supul) do
    IO.puts("Make an openhash struct of the state supul")

    {:ok, openhash} =
      Openhash.changeset(%Openhash{}, %{
        supul_id: state_supul.id,
        sender: state_supul.sender,
        incoming_hash: state_supul.incoming_hash,
        previous_hash: state_supul.previous_hash,
        current_hash: state_supul.current_hash
      })
      |> Repo.insert()

    '''
        #? add supul signature to the openhash struct.  
        #? hard coding supul private key. 
        state_supul_priv_key = ExPublicKey.load!("./keys/jejudo_private_key.pem")
        
        openhash_serialized = Poison.encode!(openhash)
        openhash_hash = Pbkdf2.hash_pwd_salt(openhash_serialized)
        {:ok, supul_signature} = ExPublicKey.sign(openhash_hash, state_supul_priv_key)

        {:ok, openhash} = Openhash.changeset(openhash, %{supul_signature: supul_signature}) 
        |> Repo.update()
    '''

    # ? put assoc
    StateSupul.changeset_openhash(state_supul, %{openhash: openhash})
    |> Repo.update!()

    # ? UPDATE OPENHASH BOX
    # ? add openhash_id to the openhash block of the supul.
    openhash_box = [openhash.id | state_supul.openhash_box]
    StateSupul.changeset(state_supul, %{openhash_box: openhash_box}) |> Repo.update()

  end

  def make_nation_openhash(nation_supul) do
    IO.puts("Make an openhash struct of the nation supul")

    {:ok, openhash} =
      Openhash.changeset(%Openhash{}, %{
        supul_id: nation_supul.id,
        sender: nation_supul.sender,
        incoming_hash: nation_supul.incoming_hash,
        previous_hash: nation_supul.previous_hash,
        current_hash: nation_supul.current_hash
      })
      |> Repo.insert()

    '''
        #? add supul signature to the openhash struct.  
        #? hard coding supul private key. 
        nation_supul_priv_key = ExPublicKey.load!("./keys/korea_private_key.pem")

        openhash_serialized = Poison.encode!(openhash)
        openhash_hash = Pbkdf2.hash_pwd_salt(openhash_serialized)
        {:ok, supul_signature} = ExPublicKey.sign(openhash_hash, nation_supul_priv_key)
        
        {:ok, openhash} = Openhash.changeset(openhash, %{supul_signature: supul_signature}) |> Repo.update()
    '''

    # ? put assoc
    NationSupul.changeset_openhash(nation_supul, %{openhash: openhash})
    |> Repo.update!()

    # ? UPDATE OPENHASH BOX
    # ? add openhash_id to the openhash block of the supul.
    openhash_box = [openhash.id | nation_supul.openhash_box]
    NationSupul.changeset(nation_supul, %{openhash_box: openhash_box}) |> Repo.update()
  end

  def make_global_openhash(global_supul) do
    IO.puts("Make an openhash struct of the global supul")

    {:ok, openhash} =
      Openhash.changeset(%Openhash{}, %{
        supul_id: global_supul.id,
        sender: global_supul.sender,
        incoming_hash: global_supul.incoming_hash,
        previous_hash: global_supul.previous_hash,
        current_hash: global_supul.current_hash
      })
      |> Repo.insert()

    # ? add supul signature to the openhash struct.  
    # ? hard coding supul private key. 
    global_supul_priv_key = ExPublicKey.load!("./keys/korea_private_key.pem")

    openhash_serialized = Poison.encode!(openhash)
    openhash_hash = Pbkdf2.hash_pwd_salt(openhash_serialized)
    {:ok, supul_signature} = ExPublicKey.sign(openhash_hash, global_supul_priv_key)

    {:ok, openhash} =
      Openhash.changeset(openhash, %{supul_signature: supul_signature}) |> Repo.update()

    # ? put assoc
    GlobalSupul.changeset_openhash(global_supul, %{openhash: openhash})
    |> Repo.update!()

    # ? UPDATE OPENHASH BOX
    # ? add openhash_id to the openhash block of the supul.
    openhash_box = [openhash.id | global_supul.openhash_box]
    GlobalSupul.changeset(global_supul, %{openhash_box: openhash_box}) |> Repo.update()
  end
end
