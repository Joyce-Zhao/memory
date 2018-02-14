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
    show = [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p]
    nums = %{a: 0,b: 1,c: 2,d: 3,e: 4,f: 5,g: 6,h: 7,i: 8,j: 9,k: 10,l: 11,m: 12,n: 13,o: 14,p: 15}
    Enum.map show, fn t ->
      s = Map.get(nums,t)
      if tiles[s].clicked == true or tiles[s].done == true do
        tiles[s].name
      else
        "_"
      end
    end
  end

  def guess(game, index) do
    ts = game.tiles
    gs = game.guess
    if ts[index].clicked == false
    and ts[index].done == false do
      cs = game.clicknum + 1
      ts = List.replace_at(ts, index, %{ts[index] | clicked: true})
    else
      cs = game.clicknum
    end

    game
    |> Map.put(:tiles, ts)
    |> Map.put(:clicknum, cs)

    cond do
      gs == -1 -> Map.put(game, :guess, index)
      Kernel.abs(ts[gs].count - ts[index].count) == 8 ->
        ts
        |> List.replace_at(index, %{ts[index] | done: true})
        |> List.replace_at(gs, %{ts[gs] | done: true})
      true ->
        ts
        |> List.replace_at(index, %{ts[index] | clicked: false})
        |> List.replace_at(gs, %{ts[gs] | clicked: false})
    end

    game
    |> Map.put(:tiles, ts)
    |> Map.put(:guess, gs)
    |> Map.put(:clicknum, cs)
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
