var rpc = json_decode(buffer_read(async_load[? "buffer"], buffer_string));

if (rpc != -1) {
	scr_parse_rpc(rpc);
	ds_map_destroy(rpc);
}