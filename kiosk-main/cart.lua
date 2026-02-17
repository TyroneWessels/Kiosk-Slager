-- Shopping Cart Module
-- Manages items selected by the customer

local cart = {}

-- Store all items in the cart
cart.items = {}

-- Add item to cart
function cart:addItem(name, price, category)
    table.insert(self.items, {
        name = name,
        price = price,
        category = category,
        id = #self.items + 1
    })
end

-- Remove item from cart by id
function cart:removeItem(id)
    for i, item in ipairs(self.items) do
        if item.id == id then
            table.remove(self.items, i)
            break
        end
    end
end

-- Get total price
function cart:getTotal()
    local total = 0
    for _, item in ipairs(self.items) do
        total = total + item.price
    end
    return total
end

-- Get number of items
function cart:getCount()
    return #self.items
end

-- Clear cart
function cart:clear()
    self.items = {}
end

-- Get all items
function cart:getItems()
    return self.items
end

return cart
