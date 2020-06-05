defmodule Demo.Votes.RoundEmbed do
    use Ecto.Schema
    import Ecto.Changeset
  
    embedded_schema do
        field :num_of_round, :integer
        field :vote_on, :date
        field :agreed_pecentage, :integer
        field :num_of_agrees, :integer
        field :num_of_disagrees, :integer
        field :sample_percentage, :integer #? percent of samples to population
        field :confidence_interval, :decimal, precision: 4, scale: 2
        field :sample_error, :decimal, precision: 4, scale: 2
        field :per_area, :map #? ex) %{서울: , 경기: 인천: ...}
        field :per_age, :map #? ex) %{10s: , 20s: 30s: ...}
        field :per_sex, :map #? ex) %{male: , female: third: ...}
        field :per_economic_class, :map #? ex) %{lower: , middle: upper: ...}
        field :per_education_degree, :map #? ex) %{elementary: , secondary: college: ...}
        field :agreed_users, {:array, :binary_id}
        field :disagreed_users, {:array, :binary_id}
        field :per_voting_power, :map #? ex) %{first: , second: third: ...}

      timestamps()
    end
  
    @fields [
        :num_of_round, 
        :vote_on,
        :num_of_agrees, 
        :num_of_disagrees, 
        :sample_percentage, 
        :confidence_interval, 
        :sample_error, 
        :per_area,
        :per_age,
        :per_sex, 
        :per_economic_class, 
        :per_education_degree,
        :agreed_users,
        :disagreed_users,
        :per_voting_power,
    ]

    @doc false
    def changeset(graduate, attrs) do
      graduate
      |> cast(attrs, @fields)
      |> validate_required([])
    end
  end
  