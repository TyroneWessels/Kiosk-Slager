-- Checkout/Payment Screen
local composer = require( "composer" )
local scene = composer.newScene()
local cart = require("cart")
local widget = require("widget")

local function gotostart()
    cart:clear()
    composer.removeScene( "afrekenen" )
    composer.gotoScene( "start" )
end

local function gotocatogorien()
    composer.removeScene( "afrekenen" )
    composer.gotoScene( "catogorien" )
end

local function processPayment()
    native.showAlert("Betaald!", "Dank je wel voor je aankoop! Totaal: €" .. string.format("%.2f", cart:getTotal()), {"OK"}, function()
        gotostart()
    end)
end

function scene:create( event )
    local sceneGroup = self.view
    
    -- Background
    local background = display.newRect(sceneGroup, display.contentWidth * 0.5, display.contentHeight * 0.5, display.contentWidth, display.contentHeight)
    background:setFillColor(0.94, 0.96, 0.98)
    background:toBack()
    
    -- Title
    local title = display.newText(sceneGroup, "Afrekenen", display.contentWidth * 0.5, 20, native.systemFont, 30)
    title:setFillColor(0.3, 0.2, 0.1)
    
    -- Items header
    local itemsHeader = display.newText(sceneGroup, "Jouw bestelling:", display.contentWidth * 0.5, 60, native.systemFont, 22)
    itemsHeader:setFillColor(0.3, 0.2, 0.1)
    
    -- Display items
    local items = cart:getItems()
    
    -- Create scrollView for items
    local scrollView = widget.newScrollView(
    {
        left = 0,
        top = 90,
        width = display.contentWidth,
        height = display.contentHeight - 140,
        scrollWidth = display.contentWidth,
        scrollHeight = (#items * 35) + 100,
        listener = scrollListener
    })
    sceneGroup:insert(scrollView)
    
    local itemHeight = 35
    
    if #items == 0 then
        local emptyText = display.newText(scrollView, "Je winkelwagen is leeg", display.contentWidth * 0.5, 50, native.systemFont, 20)
        emptyText:setFillColor(0.5, 0.5, 0.5)
    else
        for i, item in ipairs(items) do
            local y = 10 + (i - 1) * itemHeight
            
            -- Item container
            local itemRect = display.newRect(scrollView, display.contentWidth * 0.5, y, display.contentWidth - 20, 30)
            itemRect:setFillColor(0.95, 0.95, 1)
            itemRect.stroke = 1
            itemRect.strokeColor = {0.3, 0.3, 0.3}
            
            -- Item name
            local nameText = display.newText(scrollView, item.name, display.contentWidth * 0.1, y - 5, native.systemFont, 16)
            nameText:setFillColor(0, 0, 0)
            nameText.anchorX = 0
            
            -- Item quantity
            local quantityText = display.newText(scrollView, "x" .. item.quantity, display.contentWidth * 0.65, y - 5, native.systemFont, 16)
            quantityText:setFillColor(0, 0, 0)
            quantityText.anchorX = 0
            
            -- Item price
            local priceText = display.newText(scrollView, "€" .. string.format("%.2f", item.price * item.quantity), display.contentWidth * 0.9, y - 5, native.systemFont, 16)
            priceText:setFillColor(0, 0, 0.8)
            priceText.anchorX = 1
            
            -- Remove button
            local removeBtn = display.newRect(scrollView, display.contentWidth * 0.95, y + 8, 20, 20)
            removeBtn:setFillColor(1, 0, 0)
            local removeText = display.newText(scrollView, "X", display.contentWidth * 0.95, y + 8, native.systemFont, 14)
            removeText:setFillColor(1, 1, 1)
            
            local itemId = item.id
            removeBtn:addEventListener("tap", function()
                cart:removeItem(itemId)
                composer.removeScene( "afrekenen" )
                composer.gotoScene( "afrekenen" )
            end)
        end
    end
    
    -- Total section (at bottom of scroll)
    local totalY = (#items * itemHeight) + 50
    
    local divider = display.newLine(scrollView, 10, totalY - 10, display.contentWidth - 10, totalY - 10)
    divider:setColor(0.3, 0.3, 0.3)
    divider.width = 2
    
    local totalLabel = display.newText(scrollView, "TOTAAL:", display.contentWidth * 0.1, totalY + 15, native.systemFont, 24)
    totalLabel:setFillColor(0.3, 0.2, 0.1)
    totalLabel.anchorX = 0
    
    local totalPrice = display.newText(scrollView, "€" .. string.format("%.2f", cart:getTotal()), display.contentWidth * 0.9, totalY + 15, native.systemFont, 28)
    totalPrice:setFillColor(0.2, 0.8, 0.2)
    totalPrice.anchorX = 1
    
    -- Buttons (fixed at bottom, outside scrollview)
    -- Back button
    local terug = display.newRect(sceneGroup, display.contentWidth * 0.2, display.contentHeight - 50, 80, 40)
    terug:setFillColor(0.7, 0.7, 0.7)
    local terugText = display.newText(sceneGroup, "Terug", display.contentWidth * 0.2, display.contentHeight - 50, native.systemFont, 18)
    terugText:setFillColor(1, 1, 1)
    terug:addEventListener("tap", gotocatogorien)
    
    -- Pay button
    if #items > 0 then
        local payBtn = display.newRect(sceneGroup, display.contentWidth * 0.5, display.contentHeight - 50, 100, 40)
        payBtn:setFillColor(0.2, 0.7, 0.2)
        local payText = display.newText(sceneGroup, "Betaal nu", display.contentWidth * 0.5, display.contentHeight - 50, native.systemFont, 18)
        payText:setFillColor(1, 1, 1)
        payBtn:addEventListener("tap", processPayment)
    end
    
    -- Stop button
    local stoppen = display.newRect(sceneGroup, display.contentWidth * 0.8, display.contentHeight - 50, 80, 40)
    stoppen:setFillColor(1, 0, 0)
    local stopText = display.newText(sceneGroup, "Stoppen", display.contentWidth * 0.8, display.contentHeight - 50, native.systemFont, 18)
    stopText:setFillColor(1, 1, 1)
    stoppen:addEventListener("tap", gotostart)
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
