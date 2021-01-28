local function place_node(pos)
	minetest.place_node(pos)
end

minetest.register_globalstep(function()
	if not minetest.settings:get_bool("automlg") then return end

	local player = minetest.localplayer

	if not player then return end

	local wielded_item = player:get_wielded_item():get_name()

	if wielded_item ~= "mcl_buckets:bucket_water" then return end

	local pos = player:get_pos()
	local node = minetest.get_node_or_nil(vector.subtract(pos, vector.new(0, 4, 0)))

	if node == nil then return end

	if node.name ~= "air" then
		local pos_to_place = vector.subtract(pos, vector.new(0, 3, 0))
		
		place_node(pos_to_place)
		minetest.after("0.9", place_node, pos_to_place)
	end
end)

minetest.register_cheat("AutoMLG", "Player", "automlg")
