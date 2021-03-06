type_event = ds_map_find_value(async_load, "type");

switch(type_event){
	case network_type_connect:
		socket = ds_map_find_value(async_load, "socket");
		ds_list_add(socket_list, socket);
		global._player = instance_create_depth(0,0,0,obj_player);
		//show_message(str()
		ds_map_add(socket_to_instanceid, socket, global._player);
		ds_map_find_value(socket_to_instanceid, socket).name = "null";
		global.num_player++;
		notify_clients(PLAYER_EVENT.joined);
		break;
		
	case network_type_disconnect:
		socket = ds_map_find_value(async_load, "socket");
		ds_list_delete(socket_list, ds_list_find_index(socket_list, socket));
		global.num_player--;
		notify_clients(PLAYER_EVENT.left);
		break;
	
	case network_type_data:
		buffer = ds_map_find_value(async_load, "buffer");
		socket = ds_map_find_value(async_load, "id");
		//show_message("socket: " + string(socket));
		buffer_seek(buffer, buffer_seek_start, 0);
		received_packet(buffer, socket);
		break;
}