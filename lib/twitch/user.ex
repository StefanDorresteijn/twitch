defmodule Twitch.User do
    defstruct id: "",
    broadcaster_type: "",
    description: "",
    display_name: "",
    login: "",
    offline_image_url: "",
    profile_image_url: "",
    type: "",
    view_count: 0

    def get_by_name(client, name) do
        List.first(get_all_by_names(client, [name]))
    end

    def get_by_id(client, id) do
        List.first(get_all_by_ids(client, [id]))
    end

    def get_all_by_names(client, names) do
        logins = Enum.map(names, fn(name) -> "login=#{name}&" end)
        "/users?#{logins}"
        |> Twitch.fetch!(client)
        |> from_data
    end

    def get_all_by_ids(client, ids) do
        ids = Enum.map(ids, fn(id) -> "id=#{id}&" end)
        "/users?#{ids}"
        |> Twitch.fetch!(client)
        |> from_data
    end

    def from_data(response) do
        response
        |> Map.fetch!(:body)
        |> Poison.decode!
        |> Map.fetch!("data")
        |> Enum.map(fn(obj) -> string_to_atom(obj) end)
        |> Enum.map(fn(obj) -> struct(Twitch.User, obj) end)
    end

    def string_to_atom(obj) do
        Enum.map(obj, fn({k, v}) -> {String.to_atom(k), v} end)
    end

end