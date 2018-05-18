defmodule Twitch do
  use HTTPoison.Base

  @moduledoc """
  Documentation for Twitch.
  """

  @doc """
  Init

  ## Examples

      iex> Twitch.init
      %Twitch.Client{
        access_token: "123abcdsefghijklmnopqrstuvwxyz",
        expires_in: 1234567890
      }

  """
  def init do
    Twitch.Client.init(
      Application.get_env(:twitch, :client_id),
      Application.get_env(:twitch, :client_secret),
      Application.get_env(:twitch, :grant_type)
    )
  end

  def fetch!(url, client) do
    object = url
    |> Twitch.get!([{"Authorization", "Bearer #{client.access_token}"}])
  end

  def process_url(url) do
    "https://api.twitch.tv/helix" <> url
  end
  
end
