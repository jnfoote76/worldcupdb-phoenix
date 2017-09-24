defmodule WorldCupDb.Web.StadiumControllerTest do
  use WorldCupDb.Web.ConnCase

  alias WorldCupDb.Entities
  alias WorldCupDb.Entities.Stadium

  @create_attrs %{cid: "some cid", city: "some city", name: "some name"}
  @update_attrs %{cid: "some updated cid", city: "some updated city", name: "some updated name"}
  @invalid_attrs %{cid: nil, city: nil, name: nil}

  def fixture(:stadium) do
    {:ok, stadium} = Entities.create_stadium(@create_attrs)
    stadium
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, stadium_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates stadium and renders stadium when data is valid", %{conn: conn} do
    conn = post conn, stadium_path(conn, :create), stadium: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, stadium_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "cid" => "some cid",
      "city" => "some city",
      "name" => "some name"}
  end

  test "does not create stadium and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, stadium_path(conn, :create), stadium: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen stadium and renders stadium when data is valid", %{conn: conn} do
    %Stadium{id: id} = stadium = fixture(:stadium)
    conn = put conn, stadium_path(conn, :update, stadium), stadium: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, stadium_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "cid" => "some updated cid",
      "city" => "some updated city",
      "name" => "some updated name"}
  end

  test "does not update chosen stadium and renders errors when data is invalid", %{conn: conn} do
    stadium = fixture(:stadium)
    conn = put conn, stadium_path(conn, :update, stadium), stadium: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen stadium", %{conn: conn} do
    stadium = fixture(:stadium)
    conn = delete conn, stadium_path(conn, :delete, stadium)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, stadium_path(conn, :show, stadium)
    end
  end
end
