defmodule WorldCupDb.Web.PageController do
  use WorldCupDb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
