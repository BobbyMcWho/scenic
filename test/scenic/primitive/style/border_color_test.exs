#
#  Created by Boyd Multerer on 5/12/17.
#  Copyright © 2017 Kry10 Industries. All rights reserved.
#

defmodule Scenic.Primitive.Style.BorderColorTest do
  use ExUnit.Case, async: true
  doctest Scenic

  alias Scenic.Primitive.Style
  alias Scenic.Primitive.Style.BorderColor


  #============================================================================
  # verify - various forms

  test "verfy works for a single color" do
    assert BorderColor.verify( :red )
    assert BorderColor.verify( {:red} )
    assert BorderColor.verify( {:red, 128} )
    assert BorderColor.verify( {{:red, 128}} )
    assert BorderColor.verify( {1,2,3} )
    assert BorderColor.verify( {{1,2,3}} )
    assert BorderColor.verify( {1,2,3,4} )
    assert BorderColor.verify( {{1,2,3,4}} )
  end

  test "verify rejects negative channels" do
    refute BorderColor.verify( {{:red, -1}} )
    refute BorderColor.verify( {{-1,2,3,4}} )
    refute BorderColor.verify( {{1,-2,3,4}} )
    refute BorderColor.verify( {{1,2,-3,4}} )
    refute BorderColor.verify( {{1,2,3,-4}} )
  end

  test "verify rejects out of bounds channels" do
    refute BorderColor.verify( {:red, 256} )
    refute BorderColor.verify( {256,2,3,4} )
    refute BorderColor.verify( {1,256,3,4} )
    refute BorderColor.verify( {1,2,256,4} )
    refute BorderColor.verify( {1,2,3,256} )
  end

  test "verfy rejects multiple colors" do
    refute BorderColor.verify( {:red, :green} )
    refute BorderColor.verify( {:red, :green, :khaki} )
    refute BorderColor.verify( {:red, :green, :crimson, :khaki} )
    refute BorderColor.verify( {:red, {:green, 128}, {1,2,3}, {1,2,3,4}} )
  end

  test "verify! works" do
    assert BorderColor.verify!( :red )
  end

  test "verify! raises an error" do
    assert_raise Style.FormatError, fn ->
      BorderColor.verify!( {{:red, -1}} )
    end
  end

  #============================================================================
  # normalize - various forms

  test "normalize works for a single color" do
    assert BorderColor.normalize( :red )            == {{255, 0, 0, 255}}
    assert BorderColor.normalize( {:red} )          == {{255, 0, 0, 255}}
    assert BorderColor.normalize( {:red, 128} )     == {{255, 0, 0, 128}}
    assert BorderColor.normalize( {{:red, 128}} )   == {{255, 0, 0, 128}}
    assert BorderColor.normalize( {1,2,3} )         == {{1, 2, 3, 255}}
    assert BorderColor.normalize( {{1,2,3}} )       == {{1, 2, 3, 255}}
    assert BorderColor.normalize( {1,2,3,4} )       == {{1, 2, 3, 4}}
    assert BorderColor.normalize( {{1,2,3,4}} )     == {{1, 2, 3, 4}}
  end


end


