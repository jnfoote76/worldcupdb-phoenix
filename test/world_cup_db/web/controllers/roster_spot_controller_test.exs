defmodule WorldCupDb.Web.RosterSpotControllerTest do
  use WorldCupDb.Web.ConnCase

  alias WorldCupDb.Entities
  alias WorldCupDb.Entities.RosterSpot

  @create_attrs %{cid: 42, goals: 42, pid: 42, pkScores: 42, position: "some position", year: 42}
  @update_attrs %{cid: 43, goals: 43, pid: 43, pkScores: 43, position: "some updated position", year: 43}
  @invalid_attrs %{cid: nil, goals: nil, pid: nil, pkScores: nil, position: nil, year: nil}

  def fixture(:roster_spot) do
    {:ok, roster_spot} = Entities.create_roster_spot(@create_attrs)
    roster_spot
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, roster_spot_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates roster_spot and renders roster_spot when data is valid", %{conn: conn} do
    conn = post conn, roster_spot_path(conn, :create), roster_spot: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, roster_spot_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "cid" => 42,
      "goals" => 42,
      "pid" => 42,
      "pkScores" => 42,
      "position" => "some position",
      "year" => 42}
  end

  test "does not create roster_spot and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, roster_spot_path(conn, :create), roster_spot: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen roster_spot and renders roster_spot when data is valid", %{conn: conn} do
    %RosterSpot{id: id} = roster_spot = fixture(:roster_spot)
    conn = put conn, roster_spot_path(conn, :update, roster_spot), roster_spot: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, roster_spot_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "cid" => 43,
      "goals" => 43,
      "pid" => 43,
      "pkScores" => 43,
      "position" => "some updated position",
      "year" => 43}
  end

  test "does not update chosen roster_spot and renders errors when data is invalid", %{conn: conn} do
    roster_spot = fixture(:roster_spot)
    conn = put conn, roster_spot_path(conn, :update, roster_spot), roster_spot: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen roster_spot", %{conn: conn} do
    roster_spot = fixture(:roster_spot)
    conn = delete conn, roster_spot_path(conn, :delete, roster_spot)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, roster_spot_path(conn, :show, roster_spot)
    end
  end
end
