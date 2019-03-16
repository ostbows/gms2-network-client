network_destroy(tcp_client);
network_destroy(udp_client);
buffer_delete(w_buffer);

ds_map_destroy(entities);
ds_list_destroy(messages);
ds_list_destroy(pending_inputs);