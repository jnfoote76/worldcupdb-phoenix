defmodule WorldCupDb.Web.GameControllerTest do
  use WorldCupDb.Web.ConnCase

  alias WorldCupDb.Entities
  alias WorldCupDb.Entities.Game

  @create_attrs %{date: "some date", grID: "some grID", lGoals: 42, loserCID: 42, pkScore: 42, round: "some round", stadID: 42, time: "some time", wGoals: 42, winnerCID: 42, year: 42}
  @update_attrs %{date: "some updated date", grID: "some updated grID", lGoals: 43, loserCID: 43, pkScore: 43, round: "some updated round", stadID: 43, time: "some updated time", wGoals: 43, winnerCID: 43, year: 43}
  @invalid_attrs %{date: nil, grID: nil, lGoals: nil, loserCID: nil, pkScore: nil, round: nil, stadID: nil, time: nil, wGoals: nil, winnerCID: nil, year: nil}

  def fixture(:game) do
    {:ok, game} = Entities.create_game(@create_attrs)
    game
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, game_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates game and renders game when data is valid", %{conn: conn} do
    conn = post conn, game_path(conn, :create), game: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, game_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "date" => "some date",
      "grID" => "some grID",
      "lGoals" => 42,
      "loserCID" => 42,
      "pkScore" => 42,
      "round" => "some round",
      "stadID" => 42,
      "time" => "some time",
      "wGoals" => 42,
      "winnerCID" => 42,
      "year" => 42}
  end

  test "does not create game and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, game_path(conn, :create), game: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen game and renders game when data is valid", %{conn: conn} do
    %Game{id: id} = game = fixture(:game)
    conn = put conn, game_path(conn, :update, game), game: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, game_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "date" => "some updated date",
      "grID" => "some updated grID",
      "lGoals" => 43,
      "loserCID" => 43,
      "pkScore" => 43,
      "round" => "some updated round",
      "stadID" => 43,
      "time" => "some updated time",
      "wGoals" => 43,
      "winnerCID" => 43,
      "year" => 43}
  end

  test "does not update chosen game and renders errors when data is invalid", %{conn: conn} do
    game = fixture(:game)
    conn = put conn, game_path(conn, :update, game), game: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen game", %{conn: conn} do
    game = fixture(:game)
    conn = delete conn, game_path(conn, :delete, game)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, game_path(conn, :show, game)
    end
  end
end
