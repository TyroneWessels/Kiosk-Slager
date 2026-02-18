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
    
    -- ScrollView dimensions
    local scrollViewWidth = display.contentWidth - 40
    local scrollViewHeight = display.contentHeight - 220
    local scrollViewLeft = (display.contentWidth - scrollViewWidth) / 2
    local scrollViewTop = 90
    
    -- Create scrollView for items
    local scrollView = widget.newScrollView(
    {
        left = scrollViewLeft,
        top = scrollViewTop,
        width = scrollViewWidth,
        height = scrollViewHeight,
        scrollWidth = scrollViewWidth,
        scrollHeight = (#items * 45) + 120,
        isBounceEnabled = false
    })
    sceneGroup:insert(scrollView)
    
    -- Add border around scrollView
    local scrollBorder = display.newRect(sceneGroup, display.contentWidth * 0.5, scrollViewTop + (scrollViewHeight * 0.5), scrollViewWidth, scrollViewHeight)
    scrollBorder:setFillColor(0, 0, 0, 0)
    scrollBorder.stroke = 3
    scrollBorder.strokeColor = {0.3, 0.3, 0.3}
    
    local itemHeight = 45
    
    if #items == 0 then
        local emptyText = display.newText(scrollView, "Je winkelwagen is leeg", scrollViewWidth * 0.5, 50, native.systemFont, 20)
        emptyText:setFillColor(0.5, 0.5, 0.5)
        emptyText.anchorX = 0.5
    else
        for i, item in ipairs(items) do
            local y = 15 + (i - 1) * itemHeight
            
            -- Item container (gecentreerd)
            local itemRect = display.newRect(scrollView, scrollViewWidth * 0.5, y, scrollViewWidth - 20, 40)
            itemRect:setFillColor(1, 1, 1)
            itemRect.stroke = 1
            itemRect.strokeColor = {0.3, 0.3, 0.3}
            itemRect.anchorY = 0.5
            
            -- Item name (links uitgelijnd)
            local nameText = display.newText(scrollView, item.name, 30, y, native.systemFont, 16)
            nameText:setFillColor(0, 0, 0)
            nameText.anchorX = 0
            nameText.anchorY = 0.5
            
            -- Item quantity (gecentreerd)
            local quantityText = display.newText(scrollView, "x" .. item.quantity, scrollViewWidth * 0.5, y, native.systemFont, 16)
            quantityText:setFillColor(0, 0, 0)
            quantityText.anchorX = 0.5
            quantityText.anchorY = 0.5
            
            -- Item price (rechts uitgelijnd)
            local priceText = display.newText(scrollView, "€" .. string.format("%.2f", item.price * item.quantity), scrollViewWidth - 30, y, native.systemFont, 16)
            priceText:setFillColor(0, 0, 0.8)
            priceText.anchorX = 1
            priceText.anchorY = 0.5
            
            -- Remove button (rechts)
            local removeBtn = display.newRect(scrollView, scrollViewWidth - 15, y, 20, 20)
            removeBtn:setFillColor(1, 0, 0)
            removeBtn.anchorX = 0.5
            removeBtn.anchorY = 0.5
            local removeText = display.newText(scrollView, "X", scrollViewWidth - 15, y, native.systemFont, 14)
            removeText:setFillColor(1, 1, 1)
            removeText.anchorX = 0.5
            removeText.anchorY = 0.5
            
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
    
    local divider = display.newLine(scrollView, 10, totalY - 10, scrollViewWidth - 10, totalY - 10)
    divider:setColor(0.3, 0.3, 0.3)
    divider.width = 2
    
    local totalLabel = display.newText(scrollView, "TOTAAL:", 30, totalY + 15, native.systemFont, 24)
    totalLabel:setFillColor(0.3, 0.2, 0.1)
    totalLabel.anchorX = 0
    totalLabel.anchorY = 0.5
    
    local totalPrice = display.newText(scrollView, "€" .. string.format("%.2f", cart:getTotal()), scrollViewWidth - 30, totalY + 15, native.systemFont, 28)
    totalPrice:setFillColor(0.2, 0.8, 0.2)
    totalPrice.anchorX = 1
    totalPrice.anchorY = 0.5
    
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
