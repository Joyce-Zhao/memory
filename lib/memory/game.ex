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

  def guess(game, index) do
    ts = game.tiles
    gs = game.guess
    if Enum.at(ts,index).clicked == false and Enum.at(ts,index).done == false do
      cs = game.clicks + 1
      ts = List.replace_at(ts, index, %{Enum.at(ts,index) | clicked: true})
    else
      cs = game.clicks
    end

    game = game
    |> Map.put(:tiles, ts)
    |> Map.put(:clicks, cs)

    cond do
      gs == -1 -> Map.put(game, :guess, index)
      Kernel.abs(Enum.at(ts,gs).count - Enum.at(ts,index).count) == 8 ->
        ts = ts
        |> List.replace_at(index, %{Enum.at(ts,index) | done: true})
        |> List.replace_at(gs, %{Enum.at(ts,gs) | done: true})
      true ->
        ts = ts
        |> List.replace_at(index, %{Enum.at(ts,index) | clicked: false})
        |> List.replace_at(gs, %{Enum.at(ts,gs) | clicked: false})
    end

    game = game
    |> Map.put(:tiles, ts)
    |> Map.put(:guess, gs)
  end

  def flip_back(game) do
    Map.put(game, :guess, -1)
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
