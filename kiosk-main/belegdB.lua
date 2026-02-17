local composer = require( "composer" )
local scene = composer.newScene()
local cart = require("cart")

local products = {
    { name = "Kalkoen broodje", price = 5.50 },
    { name = "Rosbief broodje", price = 6.50 },
    { name = "Gerookt vlees broodje", price = 6.00 },
    { name = "Salami broodje", price = 5.00 },
    { name = "Mixte broodje", price = 6.50 },
}

local function gotostart()
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

local function addToCart(name, price)
    cart:addItem(name, price, "belegdB")
    native.showAlert("Toegevoegd", name .. " is aan je winkelwagen toegevoegd!", {"OK"})
end

function scene:create( event )
    local sceneGroup = self.view
    
    -- Title
    local title = display.newText(sceneGroup, "Belegde Broodjes", display.contentWidth * 0.5, 20, native.systemFont, 30)
    title:setFillColor(0, 0, 0)
    
    -- Display products
    local startY = 60
    local itemHeight = 60
    
    for i, product in ipairs(products) do
        local y = startY + (i - 1) * itemHeight
        
        -- Product button
        local productBtn = display.newRect(sceneGroup, display.contentWidth * 0.5, y, display.contentWidth - 20, 50)
        productBtn:setFillColor(0.9, 0.9, 0.9)
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
    
    -- Cart button
    local cartBtn = display.newRect(sceneGroup, display.contentWidth * 0.7, display.contentHeight - 50, 100, 40)
    cartBtn:setFillColor(0.2, 0.7, 0.2)
    local cartText = display.newText(sceneGroup, "Afrekenen", display.contentWidth * 0.7, display.contentHeight - 50, native.systemFont, 18)
    cartText:setFillColor(1, 1, 1)
    cartBtn:addEventListener("tap", gotoAfrekenen)
    
    -- Back button
    local terug = display.newText(sceneGroup, "Terug", display.contentWidth * 0.15, display.contentHeight - 50, native.systemFont, 18)
    terug:setFillColor(0, 0, 0)
    terug:addEventListener("tap", gotocatogorien)
    
    -- Stop button
    local stoppen = display.newText(sceneGroup, "Stoppen", display.contentWidth * 0.85, display.contentHeight - 50, native.systemFont, 18)
    stoppen:setFillColor(1, 0, 0)
    stoppen:addEventListener("tap", gotostart)
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene