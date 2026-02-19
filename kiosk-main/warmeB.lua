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

local function addToCart(name, price)
    cart:addItem(name, price, "warmeB")
    native.showAlert("Toegevoegd", name .. " is aan je winkelwagen toegevoegd!", {"OK"})
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
    
    for i, product in ipairs(products) do
        local y = startY + (i - 1) * itemHeight
        
        -- Product button
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
        
        -- Add to cart functionality
        local name = product.name
        local price = product.price
        productBtn:addEventListener("tap", function()
            addToCart(name, price)
        end)
    end

    --foto
    local Warmkipcorn = display.newImage(sceneGroup, "Foto's/Warmkipcorn.png", display.contentWidth * 0.8, 60)
    Warmkipcorn:scale(0.1, 0.1)
    local Warmvlees = display.newImage(sceneGroup, "Foto's/Warmvlees.png", display.contentWidth * 0.8, 120)
    Warmvlees:scale(0.1, 0.1)
    local Warmham = display.newImage(sceneGroup, "Foto's/Warmham.png", display.contentWidth * 0.8, 180)
    Warmham:scale(0.1, 0.1)
    local Warmkaas = display.newImage(sceneGroup, "Foto's/Warmkaas.png", display.contentWidth * 0.8, 240)
    Warmkaas:scale(0.1, 0.1)
    local Warmgezond = display.newImage(sceneGroup, "Foto's/Warmgezond.png", display.contentWidth * 0.8, 240)
    Warmgezond:scale(0.1, 0.1)
    local Warmspeciaal = display.newImage(sceneGroup, "Foto's/Warmspeciaal.png", display.contentWidth * 0.8, 300)
    Warmspeciaal:scale(0.1, 0.1)

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