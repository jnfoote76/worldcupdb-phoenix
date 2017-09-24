defmodule WorldCupDb.EntitiesTest do
  use WorldCupDb.DataCase

  alias WorldCupDb.Entities

  describe "player" do
    alias WorldCupDb.Entities.Player

    @valid_attrs %{birthdate: "some birthdate", name: "some name"}
    @update_attrs %{birthdate: "some updated birthdate", name: "some updated name"}
    @invalid_attrs %{birthdate: nil, name: nil}

    def player_fixture(attrs \\ %{}) do
      {:ok, player} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Entities.create_player()

      player
    end

    test "list_player/0 returns all player" do
      player = player_fixture()
      assert Entities.list_player() == [player]
    end

    test "get_player!/1 returns the player with given id" do
      player = player_fixture()
      assert Entities.get_player!(player.id) == player
    end

    test "create_player/1 with valid data creates a player" do
      assert {:ok, %Player{} = player} = Entities.create_player(@valid_attrs)
      assert player.birthdate == "some birthdate"
      assert player.name == "some name"
    end

    test "create_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entities.create_player(@invalid_attrs)
    end

    test "update_player/2 with valid data updates the player" do
      player = player_fixture()
      assert {:ok, player} = Entities.update_player(player, @update_attrs)
      assert %Player{} = player
      assert player.birthdate == "some updated birthdate"
      assert player.name == "some updated name"
    end

    test "update_player/2 with invalid data returns error changeset" do
      player = player_fixture()
      assert {:error, %Ecto.Changeset{}} = Entities.update_player(player, @invalid_attrs)
      assert player == Entities.get_player!(player.id)
    end

    test "delete_player/1 deletes the player" do
      player = player_fixture()
      assert {:ok, %Player{}} = Entities.delete_player(player)
      assert_raise Ecto.NoResultsError, fn -> Entities.get_player!(player.id) end
    end

    test "change_player/1 returns a player changeset" do
      player = player_fixture()
      assert %Ecto.Changeset{} = Entities.change_player(player)
    end
  end

  describe "countries" do
    alias WorldCupDb.Entities.Country

    @valid_attrs %{crestURL: "some crestURL", name: "some name", string: "some string"}
    @update_attrs %{crestURL: "some updated crestURL", name: "some updated name", string: "some updated string"}
    @invalid_attrs %{crestURL: nil, name: nil, string: nil}

    def country_fixture(attrs \\ %{}) do
      {:ok, country} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Entities.create_country()

      country
    end

    test "list_countries/0 returns all countries" do
      country = country_fixture()
      assert Entities.list_countries() == [country]
    end

    test "get_country!/1 returns the country with given id" do
      country = country_fixture()
      assert Entities.get_country!(country.id) == country
    end

    test "create_country/1 with valid data creates a country" do
      assert {:ok, %Country{} = country} = Entities.create_country(@valid_attrs)
      assert country.crestURL == "some crestURL"
      assert country.name == "some name"
      assert country.string == "some string"
    end

    test "create_country/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entities.create_country(@invalid_attrs)
    end

    test "update_country/2 with valid data updates the country" do
      country = country_fixture()
      assert {:ok, country} = Entities.update_country(country, @update_attrs)
      assert %Country{} = country
      assert country.crestURL == "some updated crestURL"
      assert country.name == "some updated name"
      assert country.string == "some updated string"
    end

    test "update_country/2 with invalid data returns error changeset" do
      country = country_fixture()
      assert {:error, %Ecto.Changeset{}} = Entities.update_country(country, @invalid_attrs)
      assert country == Entities.get_country!(country.id)
    end

    test "delete_country/1 deletes the country" do
      country = country_fixture()
      assert {:ok, %Country{}} = Entities.delete_country(country)
      assert_raise Ecto.NoResultsError, fn -> Entities.get_country!(country.id) end
    end

    test "change_country/1 returns a country changeset" do
      country = country_fixture()
      assert %Ecto.Changeset{} = Entities.change_country(country)
    end
  end

  describe "cups" do
    alias WorldCupDb.Entities.Cup

    @valid_attrs %{hostCID: 42, winnerCID: 42, year: 42}
    @update_attrs %{hostCID: 43, winnerCID: 43, year: 43}
    @invalid_attrs %{hostCID: nil, winnerCID: nil, year: nil}

    def cup_fixture(attrs \\ %{}) do
      {:ok, cup} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Entities.create_cup()

      cup
    end

    test "list_cups/0 returns all cups" do
      cup = cup_fixture()
      assert Entities.list_cups() == [cup]
    end

    test "get_cup!/1 returns the cup with given id" do
      cup = cup_fixture()
      assert Entities.get_cup!(cup.id) == cup
    end

    test "create_cup/1 with valid data creates a cup" do
      assert {:ok, %Cup{} = cup} = Entities.create_cup(@valid_attrs)
      assert cup.hostCID == 42
      assert cup.winnerCID == 42
      assert cup.year == 42
    end

    test "create_cup/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entities.create_cup(@invalid_attrs)
    end

    test "update_cup/2 with valid data updates the cup" do
      cup = cup_fixture()
      assert {:ok, cup} = Entities.update_cup(cup, @update_attrs)
      assert %Cup{} = cup
      assert cup.hostCID == 43
      assert cup.winnerCID == 43
      assert cup.year == 43
    end

    test "update_cup/2 with invalid data returns error changeset" do
      cup = cup_fixture()
      assert {:error, %Ecto.Changeset{}} = Entities.update_cup(cup, @invalid_attrs)
      assert cup == Entities.get_cup!(cup.id)
    end

    test "delete_cup/1 deletes the cup" do
      cup = cup_fixture()
      assert {:ok, %Cup{}} = Entities.delete_cup(cup)
      assert_raise Ecto.NoResultsError, fn -> Entities.get_cup!(cup.id) end
    end

    test "change_cup/1 returns a cup changeset" do
      cup = cup_fixture()
      assert %Ecto.Changeset{} = Entities.change_cup(cup)
    end
  end

  describe "stadiums" do
    alias WorldCupDb.Entities.Stadium

    @valid_attrs %{cid: "some cid", city: "some city", name: "some name"}
    @update_attrs %{cid: "some updated cid", city: "some updated city", name: "some updated name"}
    @invalid_attrs %{cid: nil, city: nil, name: nil}

    def stadium_fixture(attrs \\ %{}) do
      {:ok, stadium} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Entities.create_stadium()

      stadium
    end

    test "list_stadiums/0 returns all stadiums" do
      stadium = stadium_fixture()
      assert Entities.list_stadiums() == [stadium]
    end

    test "get_stadium!/1 returns the stadium with given id" do
      stadium = stadium_fixture()
      assert Entities.get_stadium!(stadium.id) == stadium
    end

    test "create_stadium/1 with valid data creates a stadium" do
      assert {:ok, %Stadium{} = stadium} = Entities.create_stadium(@valid_attrs)
      assert stadium.cid == "some cid"
      assert stadium.city == "some city"
      assert stadium.name == "some name"
    end

    test "create_stadium/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entities.create_stadium(@invalid_attrs)
    end

    test "update_stadium/2 with valid data updates the stadium" do
      stadium = stadium_fixture()
      assert {:ok, stadium} = Entities.update_stadium(stadium, @update_attrs)
      assert %Stadium{} = stadium
      assert stadium.cid == "some updated cid"
      assert stadium.city == "some updated city"
      assert stadium.name == "some updated name"
    end

    test "update_stadium/2 with invalid data returns error changeset" do
      stadium = stadium_fixture()
      assert {:error, %Ecto.Changeset{}} = Entities.update_stadium(stadium, @invalid_attrs)
      assert stadium == Entities.get_stadium!(stadium.id)
    end

    test "delete_stadium/1 deletes the stadium" do
      stadium = stadium_fixture()
      assert {:ok, %Stadium{}} = Entities.delete_stadium(stadium)
      assert_raise Ecto.NoResultsError, fn -> Entities.get_stadium!(stadium.id) end
    end

    test "change_stadium/1 returns a stadium changeset" do
      stadium = stadium_fixture()
      assert %Ecto.Changeset{} = Entities.change_stadium(stadium)
    end
  end

  describe "roster_spots" do
    alias WorldCupDb.Entities.RosterSpot

    @valid_attrs %{cid: 42, goals: 42, pid: 42, pkScores: 42, position: "some position", year: 42}
    @update_attrs %{cid: 43, goals: 43, pid: 43, pkScores: 43, position: "some updated position", year: 43}
    @invalid_attrs %{cid: nil, goals: nil, pid: nil, pkScores: nil, position: nil, year: nil}

    def roster_spot_fixture(attrs \\ %{}) do
      {:ok, roster_spot} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Entities.create_roster_spot()

      roster_spot
    end

    test "list_roster_spots/0 returns all roster_spots" do
      roster_spot = roster_spot_fixture()
      assert Entities.list_roster_spots() == [roster_spot]
    end

    test "get_roster_spot!/1 returns the roster_spot with given id" do
      roster_spot = roster_spot_fixture()
      assert Entities.get_roster_spot!(roster_spot.id) == roster_spot
    end

    test "create_roster_spot/1 with valid data creates a roster_spot" do
      assert {:ok, %RosterSpot{} = roster_spot} = Entities.create_roster_spot(@valid_attrs)
      assert roster_spot.cid == 42
      assert roster_spot.goals == 42
      assert roster_spot.pid == 42
      assert roster_spot.pkScores == 42
      assert roster_spot.position == "some position"
      assert roster_spot.year == 42
    end

    test "create_roster_spot/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entities.create_roster_spot(@invalid_attrs)
    end

    test "update_roster_spot/2 with valid data updates the roster_spot" do
      roster_spot = roster_spot_fixture()
      assert {:ok, roster_spot} = Entities.update_roster_spot(roster_spot, @update_attrs)
      assert %RosterSpot{} = roster_spot
      assert roster_spot.cid == 43
      assert roster_spot.goals == 43
      assert roster_spot.pid == 43
      assert roster_spot.pkScores == 43
      assert roster_spot.position == "some updated position"
      assert roster_spot.year == 43
    end

    test "update_roster_spot/2 with invalid data returns error changeset" do
      roster_spot = roster_spot_fixture()
      assert {:error, %Ecto.Changeset{}} = Entities.update_roster_spot(roster_spot, @invalid_attrs)
      assert roster_spot == Entities.get_roster_spot!(roster_spot.id)
    end

    test "delete_roster_spot/1 deletes the roster_spot" do
      roster_spot = roster_spot_fixture()
      assert {:ok, %RosterSpot{}} = Entities.delete_roster_spot(roster_spot)
      assert_raise Ecto.NoResultsError, fn -> Entities.get_roster_spot!(roster_spot.id) end
    end

    test "change_roster_spot/1 returns a roster_spot changeset" do
      roster_spot = roster_spot_fixture()
      assert %Ecto.Changeset{} = Entities.change_roster_spot(roster_spot)
    end
  end

  describe "country_participations" do
    alias WorldCupDb.Entities.CountryParticipation

    @valid_attrs %{cid: 42, result: 42, year: 42}
    @update_attrs %{cid: 43, result: 43, year: 43}
    @invalid_attrs %{cid: nil, result: nil, year: nil}

    def country_participation_fixture(attrs \\ %{}) do
      {:ok, country_participation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Entities.create_country_participation()

      country_participation
    end

    test "list_country_participations/0 returns all country_participations" do
      country_participation = country_participation_fixture()
      assert Entities.list_country_participations() == [country_participation]
    end

    test "get_country_participation!/1 returns the country_participation with given id" do
      country_participation = country_participation_fixture()
      assert Entities.get_country_participation!(country_participation.id) == country_participation
    end

    test "create_country_participation/1 with valid data creates a country_participation" do
      assert {:ok, %CountryParticipation{} = country_participation} = Entities.create_country_participation(@valid_attrs)
      assert country_participation.cid == 42
      assert country_participation.result == 42
      assert country_participation.year == 42
    end

    test "create_country_participation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entities.create_country_participation(@invalid_attrs)
    end

    test "update_country_participation/2 with valid data updates the country_participation" do
      country_participation = country_participation_fixture()
      assert {:ok, country_participation} = Entities.update_country_participation(country_participation, @update_attrs)
      assert %CountryParticipation{} = country_participation
      assert country_participation.cid == 43
      assert country_participation.result == 43
      assert country_participation.year == 43
    end

    test "update_country_participation/2 with invalid data returns error changeset" do
      country_participation = country_participation_fixture()
      assert {:error, %Ecto.Changeset{}} = Entities.update_country_participation(country_participation, @invalid_attrs)
      assert country_participation == Entities.get_country_participation!(country_participation.id)
    end

    test "delete_country_participation/1 deletes the country_participation" do
      country_participation = country_participation_fixture()
      assert {:ok, %CountryParticipation{}} = Entities.delete_country_participation(country_participation)
      assert_raise Ecto.NoResultsError, fn -> Entities.get_country_participation!(country_participation.id) end
    end

    test "change_country_participation/1 returns a country_participation changeset" do
      country_participation = country_participation_fixture()
      assert %Ecto.Changeset{} = Entities.change_country_participation(country_participation)
    end
  end

  describe "games" do
    alias WorldCupDb.Entities.Game

    @valid_attrs %{date: "some date", grID: "some grID", lGoals: 42, loserCID: 42, pkScore: 42, round: "some round", stadID: 42, time: "some time", wGoals: 42, winnerCID: 42, year: 42}
    @update_attrs %{date: "some updated date", grID: "some updated grID", lGoals: 43, loserCID: 43, pkScore: 43, round: "some updated round", stadID: 43, time: "some updated time", wGoals: 43, winnerCID: 43, year: 43}
    @invalid_attrs %{date: nil, grID: nil, lGoals: nil, loserCID: nil, pkScore: nil, round: nil, stadID: nil, time: nil, wGoals: nil, winnerCID: nil, year: nil}

    def game_fixture(attrs \\ %{}) do
      {:ok, game} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Entities.create_game()

      game
    end

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Entities.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Entities.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      assert {:ok, %Game{} = game} = Entities.create_game(@valid_attrs)
      assert game.date == "some date"
      assert game.grID == "some grID"
      assert game.lGoals == 42
      assert game.loserCID == 42
      assert game.pkScore == 42
      assert game.round == "some round"
      assert game.stadID == 42
      assert game.time == "some time"
      assert game.wGoals == 42
      assert game.winnerCID == 42
      assert game.year == 42
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entities.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      assert {:ok, game} = Entities.update_game(game, @update_attrs)
      assert %Game{} = game
      assert game.date == "some updated date"
      assert game.grID == "some updated grID"
      assert game.lGoals == 43
      assert game.loserCID == 43
      assert game.pkScore == 43
      assert game.round == "some updated round"
      assert game.stadID == 43
      assert game.time == "some updated time"
      assert game.wGoals == 43
      assert game.winnerCID == 43
      assert game.year == 43
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Entities.update_game(game, @invalid_attrs)
      assert game == Entities.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Entities.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Entities.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Entities.change_game(game)
    end
  end
end
