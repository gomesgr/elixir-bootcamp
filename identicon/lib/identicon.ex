defmodule Identicon do
	def main(input) do
		input
		|> hash_input()
		|> pick_color()
		|> build_grid()
	end

	def build_grid(%Identicon.Image{hex: hex} = image) do
		hex
		|> Enum.chunk(3)
		|> Enum.map(&mirror_row/1)
	end

	def pick_color(%Identicon.Image{hex: [red, green, blue | _tail]} = image) do
		# Way 1, way 2 is putting the pattern matching in the argument
		# %Identicon.Image{hex: [red, green, blue | _tail]} = image
		%Identicon.Image{image | color: {red, green, blue}}
	end

	def hash_input(input) do
		hex = :crypto.hash(:md5, input)
		|> :binary.bin_to_list()
		
		%Identicon.Image{hex: hex}
	end

	def mirror_row(row) do
		# [145, 24, 200]
		[first, second, _third] = row
		row ++ [second, first]

		# [145, 24, 200, 24, 145]
	end
end
