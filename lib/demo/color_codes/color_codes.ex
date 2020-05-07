defmodule Demo.ColorCodes do
  @moduledoc """
  The ColorCodes context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.ColorCodes.ColorCode

  @doc """
  Returns the list of color_codes.

  ## Examples

      iex> list_color_codes()
      [%ColorCode{}, ...]

  """
  def list_color_codes do
    Repo.all(ColorCode)
  end

  @doc """
  Gets a single color_code.

  Raises `Ecto.NoResultsError` if the Color code does not exist.

  ## Examples

      iex> get_color_code!(123)
      %ColorCode{}

      iex> get_color_code!(456)
      ** (Ecto.NoResultsError)

  """
  def get_color_code!(id), do: Repo.get!(ColorCode, id)

  @doc """
  Creates a color_code.

  ## Examples

      iex> create_color_code(%{field: value})
      {:ok, %ColorCode{}}

      iex> create_color_code(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_color_code(attrs \\ %{}) do
    %ColorCode{}
    |> ColorCode.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a color_code.

  ## Examples

      iex> update_color_code(color_code, %{field: new_value})
      {:ok, %ColorCode{}}

      iex> update_color_code(color_code, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_color_code(%ColorCode{} = color_code, attrs) do
    color_code
    |> ColorCode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a color_code.

  ## Examples

      iex> delete_color_code(color_code)
      {:ok, %ColorCode{}}

      iex> delete_color_code(color_code)
      {:error, %Ecto.Changeset{}}

  """
  def delete_color_code(%ColorCode{} = color_code) do
    Repo.delete(color_code)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking color_code changes.

  ## Examples

      iex> change_color_code(color_code)
      %Ecto.Changeset{source: %ColorCode{}}

  """
  def change_color_code(%ColorCode{} = color_code) do
    ColorCode.changeset(color_code, %{})
  end
end
