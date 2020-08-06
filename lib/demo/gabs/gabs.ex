defmodule Demo.Gabs do


  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Gabs.Gab


  def list_gabs do
    Repo.all(Gab)
  end


  def get_gab!(id), do: Repo.get!(Gab, id)


  def create_gab(attrs \\ %{}) do
    t1_list = T1Lists.create_t1_list()
    t2_list = T2Lists.create_t2_list()
    t3_list = T3Lists.create_t3_list()
    t4_list = T4Lists.create_t4_list()
    t5_list = T5Lists.create_t5_list()

    attrs = Map.merge(%{
      t1_list: t1_list, 
      t2_list: t2_list, 
      t3_list: t3_list, 
      t4_list: t4_list, 
      t5_list: t5_list
      })

    %Gab{}
    |> Gab.changeset(attrs)
    |> Repo.insert()
  end



  def update_gab(%Gab{} = gab, attrs) do
    gab
    |> Gab.changeset(attrs)
    |> Repo.update()
  end


  def delete_gab(%Gab{} = gab) do
    Repo.delete(gab)
  end


  def change_gab(%Gab{} = gab) do
    Gab.changeset(gab, %{})
  end

  def get_fx_rate(fiat_a, fiat_b) do
    #? dummy data
    1
end
