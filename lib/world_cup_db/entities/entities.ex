defmodule WorldCupDb.Entities do
  @moduledoc """
  The boundary for the Entities system.
  """

  import Ecto.Query, warn: false
  alias WorldCupDb.Repo

  alias WorldCupDb.Entities.Player

  @doc """
  Returns the list of player.

  ## Examples

      iex> list_player()
      [%Player{}, ...]

  """
  def list_player do
    Repo.all(Player)
  end

  @doc """
  Gets a single player.

  Raises `Ecto.NoResultsError` if the Player does not exist.

  ## Examples

      iex> get_player!(123)
      %Player{}

      iex> get_player!(456)
      ** (Ecto.NoResultsError)

  """
  def get_player!(id), do: Repo.get!(Player, id)

  @doc """
  Creates a player.

  ## Examples

      iex> create_player(%{field: value})
      {:ok, %Player{}}

      iex> create_player(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_player(attrs \\ %{}) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a player.

  ## Examples

      iex> update_player(player, %{field: new_value})
      {:ok, %Player{}}

      iex> update_player(player, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_player(%Player{} = player, attrs) do
    player
    |> Player.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Player.

  ## Examples

      iex> delete_player(player)
      {:ok, %Player{}}

      iex> delete_player(player)
      {:error, %Ecto.Changeset{}}

  """
  def delete_player(%Player{} = player) do
    Repo.delete(player)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking player changes.

  ## Examples

      iex> change_player(player)
      %Ecto.Changeset{source: %Player{}}

  """
  def change_player(%Player{} = player) do
    Player.changeset(player, %{})
  end

  alias WorldCupDb.Entities.Country

  @doc """
  Returns the list of countries.

  ## Examples

      iex> list_countries()
      [%Country{}, ...]

  """
  def list_countries do
    Repo.all(Country)
  end

  @doc """
  Gets a single country.

  Raises `Ecto.NoResultsError` if the Country does not exist.

  ## Examples

      iex> get_country!(123)
      %Country{}

      iex> get_country!(456)
      ** (Ecto.NoResultsError)

  """
  def get_country!(id), do: Repo.get!(Country, id)

  @doc """
  Creates a country.

  ## Examples

      iex> create_country(%{field: value})
      {:ok, %Country{}}

      iex> create_country(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_country(attrs \\ %{}) do
    %Country{}
    |> Country.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a country.

  ## Examples

      iex> update_country(country, %{field: new_value})
      {:ok, %Country{}}

      iex> update_country(country, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_country(%Country{} = country, attrs) do
    country
    |> Country.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Country.

  ## Examples

      iex> delete_country(country)
      {:ok, %Country{}}

      iex> delete_country(country)
      {:error, %Ecto.Changeset{}}

  """
  def delete_country(%Country{} = country) do
    Repo.delete(country)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking country changes.

  ## Examples

      iex> change_country(country)
      %Ecto.Changeset{source: %Country{}}

  """
  def change_country(%Country{} = country) do
    Country.changeset(country, %{})
  end

  alias WorldCupDb.Entities.Cup

  @doc """
  Returns the list of cups.

  ## Examples

      iex> list_cups()
      [%Cup{}, ...]

  """
  def list_cups do
    Repo.all(Cup)
  end

  @doc """
  Gets a single cup.

  Raises `Ecto.NoResultsError` if the Cup does not exist.

  ## Examples

      iex> get_cup!(123)
      %Cup{}

      iex> get_cup!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cup!(id), do: Repo.get!(Cup, id)

  @doc """
  Creates a cup.

  ## Examples

      iex> create_cup(%{field: value})
      {:ok, %Cup{}}

      iex> create_cup(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cup(attrs \\ %{}) do
    %Cup{}
    |> Cup.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cup.

  ## Examples

      iex> update_cup(cup, %{field: new_value})
      {:ok, %Cup{}}

      iex> update_cup(cup, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cup(%Cup{} = cup, attrs) do
    cup
    |> Cup.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Cup.

  ## Examples

      iex> delete_cup(cup)
      {:ok, %Cup{}}

      iex> delete_cup(cup)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cup(%Cup{} = cup) do
    Repo.delete(cup)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cup changes.

  ## Examples

      iex> change_cup(cup)
      %Ecto.Changeset{source: %Cup{}}

  """
  def change_cup(%Cup{} = cup) do
    Cup.changeset(cup, %{})
  end

  alias WorldCupDb.Entities.Stadium

  @doc """
  Returns the list of stadiums.

  ## Examples

      iex> list_stadiums()
      [%Stadium{}, ...]

  """
  def list_stadiums do
    Repo.all(Stadium)
  end

  @doc """
  Gets a single stadium.

  Raises `Ecto.NoResultsError` if the Stadium does not exist.

  ## Examples

      iex> get_stadium!(123)
      %Stadium{}

      iex> get_stadium!(456)
      ** (Ecto.NoResultsError)

  """
  def get_stadium!(id), do: Repo.get!(Stadium, id)

  @doc """
  Creates a stadium.

  ## Examples

      iex> create_stadium(%{field: value})
      {:ok, %Stadium{}}

      iex> create_stadium(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_stadium(attrs \\ %{}) do
    %Stadium{}
    |> Stadium.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a stadium.

  ## Examples

      iex> update_stadium(stadium, %{field: new_value})
      {:ok, %Stadium{}}

      iex> update_stadium(stadium, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_stadium(%Stadium{} = stadium, attrs) do
    stadium
    |> Stadium.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Stadium.

  ## Examples

      iex> delete_stadium(stadium)
      {:ok, %Stadium{}}

      iex> delete_stadium(stadium)
      {:error, %Ecto.Changeset{}}

  """
  def delete_stadium(%Stadium{} = stadium) do
    Repo.delete(stadium)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stadium changes.

  ## Examples

      iex> change_stadium(stadium)
      %Ecto.Changeset{source: %Stadium{}}

  """
  def change_stadium(%Stadium{} = stadium) do
    Stadium.changeset(stadium, %{})
  end

  alias WorldCupDb.Entities.RosterSpot

  @doc """
  Returns the list of roster_spots.

  ## Examples

      iex> list_roster_spots()
      [%RosterSpot{}, ...]

  """
  def list_roster_spots do
    Repo.all(RosterSpot)
  end

  @doc """
  Gets a single roster_spot.

  Raises `Ecto.NoResultsError` if the Roster spot does not exist.

  ## Examples

      iex> get_roster_spot!(123)
      %RosterSpot{}

      iex> get_roster_spot!(456)
      ** (Ecto.NoResultsError)

  """
  def get_roster_spot!(id), do: Repo.get!(RosterSpot, id)

  @doc """
  Creates a roster_spot.

  ## Examples

      iex> create_roster_spot(%{field: value})
      {:ok, %RosterSpot{}}

      iex> create_roster_spot(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_roster_spot(attrs \\ %{}) do
    %RosterSpot{}
    |> RosterSpot.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a roster_spot.

  ## Examples

      iex> update_roster_spot(roster_spot, %{field: new_value})
      {:ok, %RosterSpot{}}

      iex> update_roster_spot(roster_spot, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_roster_spot(%RosterSpot{} = roster_spot, attrs) do
    roster_spot
    |> RosterSpot.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a RosterSpot.

  ## Examples

      iex> delete_roster_spot(roster_spot)
      {:ok, %RosterSpot{}}

      iex> delete_roster_spot(roster_spot)
      {:error, %Ecto.Changeset{}}

  """
  def delete_roster_spot(%RosterSpot{} = roster_spot) do
    Repo.delete(roster_spot)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking roster_spot changes.

  ## Examples

      iex> change_roster_spot(roster_spot)
      %Ecto.Changeset{source: %RosterSpot{}}

  """
  def change_roster_spot(%RosterSpot{} = roster_spot) do
    RosterSpot.changeset(roster_spot, %{})
  end

  alias WorldCupDb.Entities.CountryParticipation

  @doc """
  Returns the list of country_participations.

  ## Examples

      iex> list_country_participations()
      [%CountryParticipation{}, ...]

  """
  def list_country_participations do
    Repo.all(CountryParticipation)
  end

  @doc """
  Gets a single country_participation.

  Raises `Ecto.NoResultsError` if the Country participation does not exist.

  ## Examples

      iex> get_country_participation!(123)
      %CountryParticipation{}

      iex> get_country_participation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_country_participation!(id), do: Repo.get!(CountryParticipation, id)

  @doc """
  Creates a country_participation.

  ## Examples

      iex> create_country_participation(%{field: value})
      {:ok, %CountryParticipation{}}

      iex> create_country_participation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_country_participation(attrs \\ %{}) do
    %CountryParticipation{}
    |> CountryParticipation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a country_participation.

  ## Examples

      iex> update_country_participation(country_participation, %{field: new_value})
      {:ok, %CountryParticipation{}}

      iex> update_country_participation(country_participation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_country_participation(%CountryParticipation{} = country_participation, attrs) do
    country_participation
    |> CountryParticipation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a CountryParticipation.

  ## Examples

      iex> delete_country_participation(country_participation)
      {:ok, %CountryParticipation{}}

      iex> delete_country_participation(country_participation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_country_participation(%CountryParticipation{} = country_participation) do
    Repo.delete(country_participation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking country_participation changes.

  ## Examples

      iex> change_country_participation(country_participation)
      %Ecto.Changeset{source: %CountryParticipation{}}

  """
  def change_country_participation(%CountryParticipation{} = country_participation) do
    CountryParticipation.changeset(country_participation, %{})
  end

  alias WorldCupDb.Entities.Game

  @doc """
  Returns the list of games.

  ## Examples

      iex> list_games()
      [%Game{}, ...]

  """
  def list_games do
    Repo.all(Game)
  end

  @doc """
  Gets a single game.

  Raises `Ecto.NoResultsError` if the Game does not exist.

  ## Examples

      iex> get_game!(123)
      %Game{}

      iex> get_game!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game!(id), do: Repo.get!(Game, id)

  @doc """
  Creates a game.

  ## Examples

      iex> create_game(%{field: value})
      {:ok, %Game{}}

      iex> create_game(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game(attrs \\ %{}) do
    %Game{}
    |> Game.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a game.

  ## Examples

      iex> update_game(game, %{field: new_value})
      {:ok, %Game{}}

      iex> update_game(game, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game(%Game{} = game, attrs) do
    game
    |> Game.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Game.

  ## Examples

      iex> delete_game(game)
      {:ok, %Game{}}

      iex> delete_game(game)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game(%Game{} = game) do
    Repo.delete(game)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game changes.

  ## Examples

      iex> change_game(game)
      %Ecto.Changeset{source: %Game{}}

  """
  def change_game(%Game{} = game) do
    Game.changeset(game, %{})
  end
end
