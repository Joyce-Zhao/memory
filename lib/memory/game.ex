defmodule Memory.Game do
  def new do
    %{
      tiles: next_tiles(),
      guess: -1,
      clicknum: 0,
    }
  end

  def client_view(game) do
    ts = game.tiles
    gs = game.guess
    cs = game.clicknum
  %{
    tiles: ts,
    skel: skeleton(ts),
    guess: gs,
    clicks: cs
  }
end

  def skeleton(tiles) do
    show = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    Enum.map show, fn t ->
      if Keyword.get(tiles[t], :clicked) == true or Keyword.get(tiles[t], :done) == true do
        Keyword.get(tiles[t], :name)
      else
        "_"
      end
    end
  end

  def guess(game, index) do
    ts = game.tiles
    gs = game.guess
    if Keyword.get(ts[index], :clicked) == false
    and Keyword.get(ts[index], :done) == false do
      cs = game.clicknum + 1
      ts = List.replace_at(ts, index, Keyword.replace!(ts[index], :clicked, true))
    else
      cs = game.clicknum
    end

    game
    |> Map.put(:tiles, ts)
    |> Map.put(:clicknum, cs)

    cond do
      gs == -1 -> Map.put(game, :guess, index)
      Kernal.abs(Keyword.get(ts[gs], :count) - Keyword.get(ts[index], :count)) == 8 ->
        ts
        |> List.replace_at(index, Keyword.replace!(ts[index], :done, true))
        |> List.replace_at(gs, Keyword.replace!(ts[gs], :done, true))
      true ->
        ts
        |> List.replace_at(index, Keyword.replace!(ts[index], :clicked, false))
        |> List.replace_at(gs, Keyword.replace!(ts[gs], :clicked, false))
    end

    game
    |> Map.put(:tiles, ts)
    |> Map.put(:guess, gs)
    |> Map.put(:clicknum, cs)
  end

  def flip_back do
    Map.put(game, :guess, -1)
  end

  def next_tiles do
    tiles = [
      { name: "A", count: 0, clicked: false, done: false },
      { name: "B", count: 1, clicked: false, done: false },
      { name: "C", count: 2, clicked: false, done: false },
      { name: "D", count: 3, clicked: false, done: false },
      { name: "E", count: 4, clicked: false, done: false },
      { name: "F", count: 5, clicked: false, done: false },
      { name: "G", count: 6, clicked: false, done: false },
      { name: "H", count: 7, clicked: false, done: false },
      { name: "A", count: 8, clicked: false, done: false },
      { name: "B", count: 9, clicked: false, done: false },
      { name: "C", count: 10, clicked: false, done: false },
      { name: "D", count: 11, clicked: false, done: false },
      { name: "E", count: 12, clicked: false, done: false },
      { name: "F", count: 13, clicked: false, done: false },
      { name: "G", count: 14, clicked: false, done: false },
      { name: "H", count: 15, clicked: false, done: false }
    ],
    Enum.random(tiles)
  end
end
