local composer = require( "composer" )
 
local scene = composer.newScene()


local function gotocatogorien()
    composer.removeScene( "catogorien" )
    composer.gotoScene( "catogorien" )
end


function scene:create( event )

    local sceneGroup = self.view
    Begin = display.newText(sceneGroup, "Begin", display.contentWidth * 0.5, display.contentHeight * 0.5, native.systemFont, 40)
    Begin:addEventListener( "tap", gotocatogorien )
    
end




function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
