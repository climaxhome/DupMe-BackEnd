with(con_server) {
	buffer = argument0;
	socket = argument1;
	msgid = buffer_read(buffer, buffer_u8);
	
	switch(msgid) {
		case NETWORK.status:
			break;
		case NETWORK.game_round:
			var gameround = buffer_read(buffer, buffer_u8);
			switch(gameround) {
				case GAME_ROUND.conducter:
					conducter_game();
					break;
				case GAME_ROUND.player:
					player_game();
					break;
			}
			break;
		case NETWORK.player_config:
			var _config = buffer_read(buffer, buffer_u8);
			switch(_config) {
				case CONFIG.name:
					var token_name = buffer_read(buffer, buffer_string);
					show_message("test!!!!!");
					ds_map_add(async_load, name, token_name);
					show_message("name: " + string(ds_map_find_value(async_load, name)));
					break;
			}
	}
	
	function reset_stored_keys() {
		global.i = 0;
		global.stored_keys = 0;
	}
	
	function conducter_game() {
		var key_token = buffer_read(buffer, buffer_u8);
		global.stored_keys[global.i++] = key_token;
		for(var i = 0; i < array_length_1d(global.stored_keys); i++;) {
			show_message(global.stored_keys[i]);	
		}
		buffer_seek(server_buffer,buffer_seek_start,0);
		buffer_write(server_buffer, buffer_u8, NETWORK.status); //network type
		buffer_write(server_buffer, buffer_u8, STATUS.during_conducter_game); //game mode??
		buffer_write(server_buffer, buffer_u8, key_token); // key
		network_send_packet(socket, server_buffer, buffer_tell(server_buffer));
	}
	
	function player_game() {
	
	}
}
