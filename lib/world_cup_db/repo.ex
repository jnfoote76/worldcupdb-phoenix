defmodule WorldCupDb.Repo do
  use Ecto.Repo, otp_app: :world_cup_db

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    update_from_env_tuples = [
      {:username, "PGUSER", false},
      {:password, "PGPASSWORD", false},
      {:database, "PGDATABASE", false},
      {:hostname, "PGHOST", false},
      {:port, "PGPORT", true},
      {:url, "DATABASE_URL", false}]

    opts = List.foldr(update_from_env_tuples, opts, &set_from_env/2)
    {:ok, opts}
  end

  def set_from_env({key, env_var_str, conv_to_int}, opts) do
    case System.get_env(env_var_str) do
      nil -> opts
      val ->
        cond do 
          conv_to_int -> Keyword.put(opts, key, String.to_integer(val))
          true -> Keyword.put(opts, key, val)
        end
    end
  end
end
