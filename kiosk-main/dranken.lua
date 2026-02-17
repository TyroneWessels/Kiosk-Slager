local composer = require( "composer" )
local scene = composer.newScene()
local cart = require("cart")

local products = {
    { name = "Water", price = 1.50 },
    { name = "Cola", price = 2.00 },
    { name = "Fanta Oranje", price = 2.00 },
    { name = "Sprite", price = 2.00 },
    { name = "Appelsap", price = 2.50 },
    { name = "Koffie", price = 2.50 },
}

local function gotostart()
    cart:clear()
    composer.removeScene( "start" )
    composer.gotoScene( "start" )
end

local function gotocatogorien()
    composer.removeScene( "dranken" )
    composer.gotoScene( "catogorien" )
end

local function gotoAfrekenen()
    composer.removeScene( "dranken" )
    composer.gotoScene( "afrekenen" )
end

local function addToCart(name, price)
    cart:addItem(name, price, "dranken")
    native.showAlert("Toegevoegd", name .. " is aan je winkelwagen toegevoegd!", {"OK"})
end

function scene:create( event )
    local sceneGroup = self.view
    
    -- Background
    local background = display.newRect(sceneGroup, display.contentWidth * 0.5, display.contentHeight * 0.5, display.contentWidth, display.contentHeight)
    background:setFillColor(1.0, 0.98, 0.94)
    background:toBack()
    
    -- Title
    local title = display.newText(sceneGroup, "Dranken", display.contentWidth * 0.5, 20, native.systemFont, 30)
    title:setFillColor(0.3, 0.2, 0.1)
    
    -- Display products
    local startY = 60
    local itemHeight = 60
    local selectedButton = nil
    
    for i, product in ipairs(products) do
        local y = startY + (i - 1) * itemHeight
        
        -- Product button
        local productBtn = display.newRect(sceneGroup, display.contentWidth * 0.5, y, display.contentWidth - 20, 50)
        productBtn:setFillColor(0.9, 0.9, 0.9)
        productBtn.stroke = 2
        productBtn.strokeColor = {0, 0, 0}
        productBtn.isSelected = false
        
        -- Product name
        local nameText = display.newText(sceneGroup, product.name, display.contentWidth * 0.15, y - 10, native.systemFont, 18)
        nameText:setFillColor(0, 0, 0)
        nameText.anchorX = 0
        
        -- Price
        local priceText = display.newText(sceneGroup, "€" .. string.format("%.2f", product.price), display.contentWidth * 0.15, y + 10, native.systemFont, 16)
        priceText:setFillColor(0, 0, 0.8)
        priceText.anchorX = 0
        
        -- Add to cart functionality
        local name = product.name
        local price = product.price
        productBtn:addEventListener("tap", function()
            -- Deselect previous button
            if selectedButton and selectedButton ~= productBtn then
                selectedButton:setFillColor(0.9, 0.9, 0.9)
                selectedButton.isSelected = false
            end
            
            -- Select current button
            productBtn:setFillColor(0.8, 1.0, 0.8)
            productBtn.isSelected = true
            selectedButton = productBtn
            
            addToCart(name, price)
        end)
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