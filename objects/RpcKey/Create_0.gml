type = "0";

world_state = ds_map_create();
ds_map_add(world_state, "states", "1");
ds_map_add(world_state, "state", ds_map_create());
ds_map_add(world_state[? "state"], "entity_id", "0");
ds_map_add(world_state[? "state"], "pos_x", "1");
ds_map_add(world_state[? "state"], "last_processed_input", "2");

connected = ds_map_create();
ds_map_add(connected, "client_id", "1");

disconnected = ds_map_create();
ds_map_add(disconnected, "client_id", "1");