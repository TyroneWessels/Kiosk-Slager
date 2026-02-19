-- Shopping Cart Module
-- Manages items selected by the customer

local cart = {}

-- Store all items in the cart
cart.items = {}

-- Add item to cart with quantity
function cart:addItem(name, price, category, quantity)
    quantity = quantity or 1
    for q = 1, quantity do
        table.insert(self.items, {
            name = name,
            price = price,
            category = category,
            id = #self.items + 1
        })
    end
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

-- Get all items grouped by name
function cart:getItems()
    local grouped = {}
    local order = {}
    
    for _, item in ipairs(self.items) do
        if not grouped[item.name] then
            grouped[item.name] = {
                name = item.name,
                price = item.price,
                category = item.category,
                quantity = 0,
                id = item.id
            }
            table.insert(order, item.name)
        end
        grouped[item.name].quantity = grouped[item.name].quantity + 1
    end
    
    local result = {}
    for _, name in ipairs(order) do
        table.insert(result, grouped[name])
    end
    return result
end

-- Get count ignoring duplicates
function cart:getCount()
    return #self.items
end

return cart
