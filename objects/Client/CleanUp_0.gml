network_destroy(tcp_client);
network_destroy(udp_client);
buffer_delete(buffer);
ds_map_destroy(entities);
scr_empty_messages(messages, true);
scr_empty_pending_inputs(pending_inputs, true);