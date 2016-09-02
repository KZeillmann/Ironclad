defmodule Ironclad.PlaygroundController do
  use Ironclad.Web, :controller
  alias Ironclad.Database

  def index(conn, _params) do
    query = from d in "databases",
            select: d.name
    databases = Repo.all(query)
    IO.inspect databases
    render conn, "index.html", databases: databases
  end

  def query(conn, %{"query" => query}) do
    datasource = Repo.get_by(Database, name: query["datasource"])

    {:ok, pid} = Postgrex.start_link(hostname: datasource.location, database: datasource.database, username: datasource.username, password: datasource.password)
    query_result = Postgrex.query!(pid, query["query_text"], [])
    render conn, "result.html", query_result: query_result
  end
end
