local composer = require( "composer" )
local scene = composer.newScene()
local cart = require("cart")

local function gotostart()
    composer.removeScene( "start" )
    composer.gotoScene( "start" )
end

local function gotobelegdB()
    composer.removeScene( "catogorien" )
    composer.gotoScene( "belegdB" )
end
local function gotowarmeB()
    composer.removeScene( "catogorien" )
    composer.gotoScene( "warmeB" )
end
local function gotowraps()
    composer.removeScene( "catogorien" )
    composer.gotoScene( "wraps" )
end
local function gotosoep()
    composer.removeScene( "catogorien" )
    composer.gotoScene( "soep" )
end
local function gotodranken()
    composer.removeScene( "catogorien" )
    composer.gotoScene( "dranken" )
end

local function gotoAfrekenen()
    composer.removeScene( "catogorien" )
    composer.gotoScene( "afrekenen" )
end


function scene:create( event )
    local sceneGroup = self.view
    
    -- Background
    local background = display.newRect(sceneGroup, display.contentWidth * 0.5, display.contentHeight * 0.5, display.contentWidth, display.contentHeight)
    background:setFillColor(1, 1, 1)
    background:toBack()
    
    -- Title
    local title = display.newText(sceneGroup, "Slagerij - Bestel nu", display.contentWidth * 0.5, 15, native.systemFont, 24)
    title:setFillColor(0, 0, 0)
    
    -- Cart info at top
    local cartCount = cart:getCount()
    local cartTotal = cart:getTotal()
    
    local cartInfoText = ""
    if cartCount > 0 then
        cartInfoText = "Winkelwagen: " .. cartCount .. " items | €" .. string.format("%.2f", cartTotal)
    else
        cartInfoText = "Winkelwagen leeg"
    end
    
    local cartInfo = display.newText(sceneGroup, cartInfoText, display.contentWidth * 0.5, 40, native.systemFont, 14)
    if cartCount > 0 then
        cartInfo:setFillColor(0, 0.7, 0)
    else
        cartInfo:setFillColor(0.5, 0.5, 0.5)
    end

    -- Product category buttons
    BelegdB = display.newRect(sceneGroup, display.contentWidth * 0.3, display.contentHeight * 0.2, 100, 80)
    BelegdB:setFillColor(0.8, 0.9, 1)
    local belegdBText = display.newText(sceneGroup, "Belegde\nBroodjes", display.contentWidth * 0.3, display.contentHeight * 0.2, native.systemFont, 14)
    belegdBText:setFillColor(0, 0, 0)
    
    WarmeB = display.newRect(sceneGroup, display.contentWidth * 0.7, display.contentHeight * 0.2, 100, 80)
    WarmeB:setFillColor(1, 0.9, 0.8)
    local warmeBText = display.newText(sceneGroup, "Warme\nBroodjes", display.contentWidth * 0.7, display.contentHeight * 0.2, native.systemFont, 14)
    warmeBText:setFillColor(0, 0, 0)
    
    Wraps = display.newRect(sceneGroup, display.contentWidth * 0.3, display.contentHeight * 0.45, 100, 80)
    Wraps:setFillColor(0.9, 1, 0.8)
    local wrapsText = display.newText(sceneGroup, "Wraps", display.contentWidth * 0.3, display.contentHeight * 0.45, native.systemFont, 14)
    wrapsText:setFillColor(0, 0, 0)
    
    Soep = display.newRect(sceneGroup, display.contentWidth * 0.7, display.contentHeight * 0.45, 100, 80)
    Soep:setFillColor(1, 0.95, 0.8)
    local soepText = display.newText(sceneGroup, "Soep", display.contentWidth * 0.7, display.contentHeight * 0.45, native.systemFont, 14)
    soepText:setFillColor(0, 0, 0)
    
    Dranken = display.newRect(sceneGroup, display.contentWidth * 0.3, display.contentHeight * 0.7, 100, 80)
    Dranken:setFillColor(0.8, 0.95, 1)
    local drankenText = display.newText(sceneGroup, "Dranken", display.contentWidth * 0.3, display.contentHeight * 0.7, native.systemFont, 14)
    drankenText:setFillColor(0, 0, 0)

    -- Checkout button
    local AfrekeningBtn = display.newRect(sceneGroup, display.contentWidth * 0.5, display.contentHeight - 55, 110, 40)
    AfrekeningBtn:setFillColor(0.2, 0.7, 0.2)
    local AfrekeningText = display.newText(sceneGroup, "Afrekenen", display.contentWidth * 0.5, display.contentHeight - 55, native.systemFont, 16)
    AfrekeningText:setFillColor(1, 1, 1)
    AfrekeningBtn:addEventListener("tap", gotoAfrekenen)

    -- Stop button
    local Stoppen = display.newRect(sceneGroup, display.contentWidth * 0.85, display.contentHeight - 55, 75, 40)
    Stoppen:setFillColor(1, 0, 0)
    local StoppenText = display.newText(sceneGroup, "Stoppen", display.contentWidth * 0.85, display.contentHeight - 55, native.systemFont, 14)
    StoppenText:setFillColor(1, 1, 1)
    Stoppen:addEventListener("tap", gotostart)

    -- Category button listeners
    BelegdB:addEventListener("tap", gotobelegdB)
    WarmeB:addEventListener("tap", gotowarmeB)
    Wraps:addEventListener("tap", gotowraps)
    Soep:addEventListener("tap", gotosoep)
    Dranken:addEventListener("tap", gotodranken)
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene