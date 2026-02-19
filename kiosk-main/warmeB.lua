local composer = require( "composer" )
local scene = composer.newScene()
local cart = require("cart")

local products = {
    { name = "Kipcorn", price = 5.50 },
    { name = "Vlees broodje", price = 6.00 },
    { name = "Ham broodje", price = 5.00 },
    { name = "Kaas broodje", price = 4.50 },
    { name = "Gezond broodje", price = 5.75 },
    { name = "Speciaal broodje", price = 7.00 },
}

local function gotostart()
    cart:clear()
    composer.removeScene( "warmeB" )
    composer.removeScene( "start" )
    composer.gotoScene( "start" )
end

local function gotocatogorien()
    composer.removeScene( "warmeB" )
    composer.gotoScene( "catogorien" )
end

local function gotoAfrekenen()
    composer.removeScene( "warmeB" )
    composer.gotoScene( "afrekenen" )
end

local function addToCart(name, price, quantity)
    quantity = quantity or 1
    cart:addItem(name, price, "warmeB", quantity)
    native.showAlert("Toegevoegd", quantity .. "x " .. name .. " is aan je winkelwagen toegevoegd!", {"OK"})
end

function scene:create( event )
    local sceneGroup = self.view
    
    -- Background
    local background = display.newRect(sceneGroup, display.contentWidth * 0.5, display.contentHeight * 0.5, display.contentWidth, display.contentHeight)
    background:setFillColor(0.94, 0.96, 0.98)
    background:toBack()
    
    -- Title
    local title = display.newText(sceneGroup, "Warme Broodjes", display.contentWidth * 0.5, 20, native.systemFont, 30)
    title:setFillColor(0.3, 0.2, 0.1)
    
    -- Display products
    local startY = 60
    local itemHeight = 60
    local targetSize = 40  -- Target size for images to fit in 50px button
    
    -- Foto names for each product
    local fotoNames = {"Warmkipcorn", "Warmvlees", "Warmham", "Warmkaas", "Warmgezond", "Warmspeciaal"}
    
    for i, product in ipairs(products) do
        local y = startY + (i - 1) * itemHeight
        local quantity = 1
        
        -- Product button
        local productBtn = display.newRect(sceneGroup, display.contentWidth * 0.35, y, display.contentWidth * 0.5, 50)
        productBtn:setFillColor(1, 1, 1)
        productBtn.stroke = 2
        productBtn.strokeColor = {0, 0, 0}
        
        -- Product name
        local nameText = display.newText(sceneGroup, product.name, display.contentWidth * 0.12, y - 10, native.systemFont, 18)
        nameText:setFillColor(0, 0, 0)
        nameText.anchorX = 0
        
        -- Price
        local priceText = display.newText(sceneGroup, "€" .. string.format("%.2f", product.price), display.contentWidth * 0.12, y + 10, native.systemFont, 16)
        priceText:setFillColor(0, 0, 0.8)
        priceText.anchorX = 0
        
        -- Quantity selector
        local qtyText = display.newText(sceneGroup, tostring(quantity), display.contentWidth * 0.67, y, native.systemFont, 18)
        qtyText:setFillColor(0, 0, 0)
        
        local minusBtn = display.newRect(sceneGroup, display.contentWidth * 0.61, y, 25, 25)
        minusBtn:setFillColor(0.9, 0.3, 0.3)
        local minusText = display.newText(sceneGroup, "-", display.contentWidth * 0.61, y, native.systemFont, 20)
        minusText:setFillColor(1, 1, 1)
        
        local plusBtn = display.newRect(sceneGroup, display.contentWidth * 0.73, y, 25, 25)
        plusBtn:setFillColor(0.3, 0.7, 0.3)
        local plusText = display.newText(sceneGroup, "+", display.contentWidth * 0.73, y, native.systemFont, 20)
        plusText:setFillColor(1, 1, 1)
        
        -- Plus/minus handlers
        minusBtn:addEventListener("tap", function()
            quantity = math.max(1, quantity - 1)
            qtyText.text = tostring(quantity)
        end)
        
        plusBtn:addEventListener("tap", function()
            quantity = math.min(10, quantity + 1)
            qtyText.text = tostring(quantity)
        end)
        
        -- Add to cart functionality
        local name = product.name
        local price = product.price
        productBtn:addEventListener("tap", function()
            addToCart(name, price, quantity)
        end)
        
        -- Foto next to item - scale dynamically to fit in box
        local foto = display.newImage(sceneGroup, "Foto's/" .. fotoNames[i] .. ".png", display.contentWidth * 0.88, y)
        if foto then
            local scaleH = targetSize / foto.height
            local scaleW = targetSize / foto.width
            local scale = math.min(scaleH, scaleW)
            foto:scale(scale, scale)
        end
    end

    -- Cart button
    local cartBtn = display.newRect(sceneGroup, display.contentWidth * 0.5, display.contentHeight - 50, 100, 40)
    cartBtn:setFillColor(0.2, 0.7, 0.2)
    local cartText = display.newText(sceneGroup, "Afrekenen", display.contentWidth * 0.5, display.contentHeight - 50, native.systemFont, 18)
    cartText:setFillColor(1, 1, 1)
    cartBtn:addEventListener("tap", gotoAfrekenen)
    
    -- Back button
    local terug = display.newRect(sceneGroup, display.contentWidth * 0.15, display.contentHeight - 50, 80, 40)
    terug:setFillColor(0.7, 0.7, 0.7)
    local terugText = display.newText(sceneGroup, "Terug", display.contentWidth * 0.15, display.contentHeight - 50, native.systemFont, 18)
    terugText:setFillColor(1, 1, 1)
    terug:addEventListener("tap", gotocatogorien)
    
    -- Stop button
    local stoppen = display.newRect(sceneGroup, display.contentWidth * 0.85, display.contentHeight - 50, 80, 40)
    stoppen:setFillColor(1, 0, 0)
    local stoppenText = display.newText(sceneGroup, "Stoppen", display.contentWidth * 0.85, display.contentHeight - 50, native.systemFont, 18)
    stoppenText:setFillColor(1, 1, 1)
    stoppen:addEventListener("tap", gotostart)
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene