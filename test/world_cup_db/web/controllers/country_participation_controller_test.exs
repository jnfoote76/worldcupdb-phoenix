defmodule WorldCupDb.Web.CountryParticipationControllerTest do
  use WorldCupDb.Web.ConnCase

  alias WorldCupDb.Entities
  alias WorldCupDb.Entities.CountryParticipation

  @create_attrs %{cid: 42, result: 42, year: 42}
  @update_attrs %{cid: 43, result: 43, year: 43}
  @invalid_attrs %{cid: nil, result: nil, year: nil}

  def fixture(:country_participation) do
    {:ok, country_participation} = Entities.create_country_participation(@create_attrs)
    country_participation
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, country_participation_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates country_participation and renders country_participation when data is valid", %{conn: conn} do
    conn = post conn, country_participation_path(conn, :create), country_participation: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, country_participation_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "cid" => 42,
      "result" => 42,
      "year" => 42}
  end

  test "does not create country_participation and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, country_participation_path(conn, :create), country_participation: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen country_participation and renders country_participation when data is valid", %{conn: conn} do
    %CountryParticipation{id: id} = country_participation = fixture(:country_participation)
    conn = put conn, country_participation_path(conn, :update, country_participation), country_participation: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, country_participation_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "cid" => 43,
      "result" => 43,
      "year" => 43}
  end

  test "does not update chosen country_participation and renders errors when data is invalid", %{conn: conn} do
    country_participation = fixture(:country_participation)
    conn = put conn, country_participation_path(conn, :update, country_participation), country_participation: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen country_participation", %{conn: conn} do
    country_participation = fixture(:country_participation)
    conn = delete conn, country_participation_path(conn, :delete, country_participation)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, country_participation_path(conn, :show, country_participation)
    end
  end
end
