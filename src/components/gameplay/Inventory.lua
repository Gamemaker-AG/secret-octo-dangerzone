local Inventory = class("Inventory", Component)

function Inventory:__init(inventory)
    self.inventory = inventory or {}
end

function Inventory:add(element)
	-- #[self.inventory] behaviour is undefined in Lua 5.2.
	-- Should insert at first nil index in table
		table.insert(self.inventory, #self.inventory+1, element)
end

function Inventory:remove(element)
	self.inventory[table.getKey(self.inventory, element)] = nil
end

function Inventory:swap(element1, element2)
	self.inventory[table.getKey(self.inventory, element1)] = element2
	self.inventory[table.getKey(self.inventory, element2)] = element1
end

return Inventory
