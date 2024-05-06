local function AddPlayerModel( name, model )

    list.Set( "PlayerOptionsModel", name, model )
    player_manager.AddValidModel( name, model )
	
end

AddPlayerModel( "daves_cop", "models/humans/group05/cop_84.mdl" )