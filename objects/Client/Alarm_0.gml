while !ds_queue_empty(disconnected)
{
	var entity_id = ds_queue_dequeue(disconnected);
	
	instance_destroy(entities[? entity_id]);
	ds_map_delete(entities, entity_id);
}