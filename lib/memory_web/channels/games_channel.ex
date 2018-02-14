defmodule MemoryWeb.GamesChannel do
  use MemoryWeb, :channel

  alias Memory.Game

  def join("games:" <> name, payload, socket) do
    if authorized?(payload) do
      game = Memory.GameBackup.load(name) || Game.new()
      socket = socket
        |> assign(:game, game)
        |> assign(:name, name)
      {:ok, %{"join" => name, "game" => Game.client_view(game)}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("guess", %{"index" => index}, socket) do
    game = Game.guess(socket.assigns[:game], index)
    Memory.GameBackup.save(socket.assigns[:name], game)
    socket = assign(socket, :game, game)
     {:reply, {:ok, %{ "game" => game}}, socket}
  end

  def handle_in("flip_back", %{"game" => game}, socket) do
    game = Game.flip_back(socket.assigns[:game])
    Memory.GameBackup.save(socket.assigns[:name], game)
    socket = assign(socket, :game, game)
     {:reply, {:ok, %{ "game" => game}}, socket}
  end

  def handle_in("replay", _params, socket) do
    game = Game.new()
    socket = assign(socket, :game, game)
     {:reply, {:ok, %{ "game" => game}}, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
