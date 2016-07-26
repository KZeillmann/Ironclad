ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Ironclad.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Ironclad.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Ironclad.Repo)

