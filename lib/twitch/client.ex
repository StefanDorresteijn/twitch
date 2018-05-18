defmodule Twitch.Client do
    defstruct access_token: "",
    expires_in: 0,
    refresh_token: ""

    def init(client_id, client_secret, grant_type) do
        body = %{client_id: client_id, client_secret: client_secret, grant_type: grant_type}
        |> Poison.encode!

        "https://id.twitch.tv/oauth2/token"
        |> HTTPoison.post!(body, [{"Content-Type", "application/json"}])
        |> Map.fetch!(:body)
        |> Poison.decode!
        |> from_map
    end

    def from_map(map) do

        atom_map = for {key, val} <- map, into: %{}, do: {String.to_atom(key), val}
        
        map = atom_map
        |> Map.take(Map.keys(%Twitch.Client{}))
        
        struct(Twitch.Client, map)
    end
end