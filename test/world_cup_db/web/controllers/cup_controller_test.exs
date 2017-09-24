defmodule WorldCupDb.Web.CupControllerTest do
  use WorldCupDb.Web.ConnCase

  alias WorldCupDb.Entities
  alias WorldCupDb.Entities.Cup

  @create_attrs %{hostCID: 42, winnerCID: 42, year: 42}
  @update_attrs %{hostCID: 43, winnerCID: 43, year: 43}
  @invalid_attrs %{hostCID: nil, winnerCID: nil, year: nil}

  def fixture(:cup) do
    {:ok, cup} = Entities.create_cup(@create_attrs)
    cup
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, cup_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates cup and renders cup when data is valid", %{conn: conn} do
    conn = post conn, cup_path(conn, :create), cup: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, cup_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "hostCID" => 42,
      "winnerCID" => 42,
      "year" => 42}
  end

  test "does not create cup and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, cup_path(conn, :create), cup: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen cup and renders cup when data is valid", %{conn: conn} do
    %Cup{id: id} = cup = fixture(:cup)
    conn = put conn, cup_path(conn, :update, cup), cup: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, cup_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "hostCID" => 43,
      "winnerCID" => 43,
      "year" => 43}
  end

  test "does not update chosen cup and renders errors when data is invalid", %{conn: conn} do
    cup = fixture(:cup)
    conn = put conn, cup_path(conn, :update, cup), cup: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen cup", %{conn: conn} do
    cup = fixture(:cup)
    conn = delete conn, cup_path(conn, :delete, cup)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, cup_path(conn, :show, cup)
    end
  end
end
