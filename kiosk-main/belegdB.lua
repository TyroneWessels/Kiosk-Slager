local composer = require( "composer" )
local scene = composer.newScene()
local cart = require("cart")

local products = {
    { name = "Kalkoen broodje", price = 5.50 },
    { name = "Rosbief broodje", price = 6.50 },
    { name = "broodje makreel", price = 6.00 },
    { name = "Salami broodje", price = 5.00 },
    { name = "broodje kroket", price = 6.00 },
}

local function gotostart()
    cart:clear()
    composer.removeScene( "belegdB" )
    composer.removeScene( "start" )
    composer.gotoScene( "start" )
end

local function gotocatogorien()
    composer.removeScene( "belegdB" )
    composer.gotoScene( "catogorien" )
end

local function gotoAfrekenen()
    composer.removeScene( "belegdB" )
    composer.gotoScene( "afrekenen" )
end

local function addToCart(name, price, quantity)
    quantity = quantity or 1
    cart:addItem(name, price, "belegdB", quantity)
    native.showAlert("Toegevoegd", quantity .. "x " .. name .. " is aan je winkelwagen toegevoegd!", {"OK"})
end

function scene:create( event )
    local sceneGroup = self.view
    
    -- Background
    local background = display.newRect(sceneGroup, display.contentWidth * 0.5, display.contentHeight * 0.5, display.contentWidth, display.contentHeight)
    background:setFillColor(0.94, 0.96, 0.98)
    background:toBack()
    
    -- Title
    local title = display.newText(sceneGroup, "Belegde Broodjes", display.contentWidth * 0.5, 20, native.systemFont, 30)
    title:setFillColor(0.3, 0.2, 0.1)
    
    
    
    

    -- Display products
    local startY = 60
    local itemHeight = 60
    local targetSize = 40  -- Target size for images to fit in 50px button
    
    -- Foto names for each product
    local fotoNames = {"Belegdkalkoen", "Belegdrosbief", "Belegdmakreel", "Belegdsalami", "Belegdkroket"}
    
    -- Popup group (will be shown when item is tapped)
    local popupGroup = nil
    
    local function showQuantityPopup(name, price)
        -- Remove existing popup if any
        if popupGroup then
            popupGroup:removeSelf()
            popupGroup = nil
        end
        
        local quantity = 1
        popupGroup = display.newGroup()
        sceneGroup:insert(popupGroup)
        
        -- Dimmed background
        local dimBg = display.newRect(popupGroup, display.contentWidth * 0.5, display.contentHeight * 0.5, display.contentWidth, display.contentHeight)
        dimBg:setFillColor(0, 0, 0, 0.5)
        
        -- Popup box
        local popupBox = display.newRect(popupGroup, display.contentWidth * 0.5, display.contentHeight * 0.4, 250, 180)
        popupBox:setFillColor(1, 1, 1)
        popupBox.strokeWidth = 2
        popupBox:setStrokeColor(0.3, 0.3, 0.3)
        
        -- Product name in popup
        local popupTitle = display.newText(popupGroup, name, display.contentWidth * 0.5, display.contentHeight * 0.4 - 60, native.systemFont, 20)
        popupTitle:setFillColor(0, 0, 0)
        
        -- Price in popup
        local popupPrice = display.newText(popupGroup, "€" .. string.format("%.2f", price), display.contentWidth * 0.5, display.contentHeight * 0.4 - 35, native.systemFont, 16)
        popupPrice:setFillColor(0, 0, 0.8)
        
        -- Quantity display
        local qtyText = display.newText(popupGroup, tostring(quantity), display.contentWidth * 0.5, display.contentHeight * 0.4, native.systemFont, 28)
        qtyText:setFillColor(0, 0, 0)
        
        -- Minus button
        local minusBtn = display.newRect(popupGroup, display.contentWidth * 0.5 - 50, display.contentHeight * 0.4, 35, 35)
        minusBtn:setFillColor(0.9, 0.3, 0.3)
        local minusText = display.newText(popupGroup, "-", display.contentWidth * 0.5 - 50, display.contentHeight * 0.4, native.systemFont, 28)
        minusText:setFillColor(1, 1, 1)
        
        -- Plus button
        local plusBtn = display.newRect(popupGroup, display.contentWidth * 0.5 + 50, display.contentHeight * 0.4, 35, 35)
        plusBtn:setFillColor(0.3, 0.7, 0.3)
        local plusText = display.newText(popupGroup, "+", display.contentWidth * 0.5 + 50, display.contentHeight * 0.4, native.systemFont, 28)
        plusText:setFillColor(1, 1, 1)
        
        minusBtn:addEventListener("tap", function()
            quantity = math.max(1, quantity - 1)
            qtyText.text = tostring(quantity)
            return true
        end)
        
        plusBtn:addEventListener("tap", function()
            quantity = math.min(10, quantity + 1)
            qtyText.text = tostring(quantity)
            return true
        end)
        
        -- Add to cart button
        local addBtn = display.newRect(popupGroup, display.contentWidth * 0.5, display.contentHeight * 0.4 + 50, 150, 40)
        addBtn:setFillColor(0.2, 0.7, 0.2)
        local addText = display.newText(popupGroup, "Toevoegen", display.contentWidth * 0.5, display.contentHeight * 0.4 + 50, native.systemFont, 18)
        addText:setFillColor(1, 1, 1)
        
        addBtn:addEventListener("tap", function()
            addToCart(name, price, quantity)
            popupGroup:removeSelf()
            popupGroup = nil
            return true
        end)
        
        -- Close on dimmed background tap
        dimBg:addEventListener("tap", function()
            popupGroup:removeSelf()
            popupGroup = nil
            return true
        end)
    end
    
    for i, product in ipairs(products) do
        local y = startY + (i - 1) * itemHeight
        
        -- Product button (full width like before)
        local productBtn = display.newRect(sceneGroup, display.contentWidth * 0.5, y, display.contentWidth - 20, 50)
        productBtn:setFillColor(1, 1, 1)
        productBtn.stroke = 2
        productBtn.strokeColor = {0, 0, 0}
        
        -- Product name
        local nameText = display.newText(sceneGroup, product.name, display.contentWidth * 0.15, y - 10, native.systemFont, 18)
        nameText:setFillColor(0, 0, 0)
        nameText.anchorX = 0
        
        -- Price
        local priceText = display.newText(sceneGroup, "€" .. string.format("%.2f", product.price), display.contentWidth * 0.15, y + 10, native.systemFont, 16)
        priceText:setFillColor(0, 0, 0.8)
        priceText.anchorX = 0
        
        -- Add to cart functionality - show popup
        local name = product.name
        local price = product.price
        productBtn:addEventListener("tap", function()
            showQuantityPopup(name, price)
            return true
        end)
        
        -- Foto next to item - scale dynamically to fit in box
        local foto = display.newImage(sceneGroup, "Foto's/" .. fotoNames[i] .. ".png", display.contentWidth * 0.8, y)
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