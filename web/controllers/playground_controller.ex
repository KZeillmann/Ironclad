defmodule Ironclad.PlaygroundController do
  use Ironclad.Web, :controller
  alias Ironclad.Query, as: Query

  def index(conn, _params) do
    render conn, "index.html"
  end

  def query(conn, %{"query" => query}) do
    {:ok, pid} = Postgrex.start_link(hostname: query["connection_string"], database: query["database"], username: query["username"], password: query["password"])
    query_result = Postgrex.query!(pid, query["query_text"], [])
    # IO.inspect query_result
    render conn, "result.html", query_result: query_result
  end
end
