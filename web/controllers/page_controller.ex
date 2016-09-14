defmodule UpcomingShowFinder.PageController do
  use UpcomingShowFinder.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
