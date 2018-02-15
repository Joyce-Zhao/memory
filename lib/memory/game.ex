defmodule Memory.Game do
  def new do
    %{
      tiles: next_tiles(),
      guess: -1,
      clicks: 0,
    }
  end

  def client_view(game) do
    ts = game.tiles
    gs = game.guess
    cs = game.clicks
    %{
      tiles: ts,
      skel: skeleton(ts),
      guess: gs,
      clicks: cs
    }
end

  def skeleton(tiles) do
    show = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
    Enum.map show, fn t ->
      if Enum.at(tiles,t).clicked == true or Enum.at(tiles,t).done == true do
        Enum.at(tiles,t).name
      else
        "_"
      end
    end
  end

  @doc """
  THere are the following two cases:
    1. first click
      - guess = index
      - clicks+1
      - tiles[index].clicked = true
    2. second click
      - 2.1 match
        - guess = -1
        - clicks+1
        - tiles[guess].done = true
        - tiles[index].done = true
        - tiles[index].clicked = true
      - 2.2 mismatch
        - tiles[index].clicked = true
        - tiles[guess].clicked = true
        - guess = -1
        - clicks + 1
  """
  def guess(game, index) do
    #IO.puts("{index = #{index}; game.guess = #{game.guess}")
    cond do
      game.guess == -1 -> # first click?
        %{guess: index, clicks: game.clicks+1,
          tiles: List.replace_at(game.tiles, index, %{Enum.at(game.tiles, index) | clicked: true})
        }
      match?(game.tiles, game.guess, index) -> # match?
        %{guess: -1, clicks: game.clicks+1,
          tiles: game.tiles
                 |> List.replace_at(game.guess, %{Enum.at(game.tiles, game.guess) | done: true})
                 |> List.replace_at(index, %{Enum.at(game.tiles, index) | done: true, clicked: true})
        }
      true -> # mismatch
        %{guess: -1, clicks: game.clicks+1,
          tiles: game.tiles
                  |> List.replace_at(game.guess, %{Enum.at(game.tiles, game.guess) | clicked: true})
                  |> List.replace_at(index, %{Enum.at(game.tiles, index) | clicked: true})
        }
    end
  end

  @doc """
  Tell whether the tiles at given indices match each other
  """
  defp match?(tiles, index1, index2) do
    tile1 = tiles |> Enum.at(index1)
    tile2 = tiles |> Enum.at(index2)

    abs(tile1.count - tile2.count) == 8
  end

  def flip_back(game) do
    game
    |> Map.put(:guess, -1)
    |> Map.put(:tiles, Enum.map(game.tiles, fn(tile) -> %{tile | clicked: false} end))
  end

  def next_tiles do
    tiles = [
      %{ name: "A", count: 0, clicked: false, done: false },
      %{ name: "B", count: 1, clicked: false, done: false },
      %{ name: "C", count: 2, clicked: false, done: false },
      %{ name: "D", count: 3, clicked: false, done: false },
      %{ name: "E", count: 4, clicked: false, done: false },
      %{ name: "F", count: 5, clicked: false, done: false },
      %{ name: "G", count: 6, clicked: false, done: false },
      %{ name: "H", count: 7, clicked: false, done: false },
      %{ name: "A", count: 8, clicked: false, done: false },
      %{ name: "B", count: 9, clicked: false, done: false },
      %{ name: "C", count: 10, clicked: false, done: false },
      %{ name: "D", count: 11, clicked: false, done: false },
      %{ name: "E", count: 12, clicked: false, done: false },
      %{ name: "F", count: 13, clicked: false, done: false },
      %{ name: "G", count: 14, clicked: false, done: false },
      %{ name: "H", count: 15, clicked: false, done: false }]
    Enum.shuffle(tiles)
  end
end
