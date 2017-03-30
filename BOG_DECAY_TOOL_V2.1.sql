--Decay Query Based on timestamp already in the game
--This has been tested in prod on A15 Server (https://topconanservers.com/server/172.96.164.194:24023)
--Updated to run faster without as many date translation
--Changed the update statement so that if you run this often, if the in game timestamp were ever to break, your characters wouldn't get deleted until they fixed it
update characters set lastTimeOnline = strftime('%s', 'now') where lastTimeOnline is NULL;
delete from buildable_health where object_id in (select distinct object_id from buildings where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-7 days') and owner_id not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null)));
delete from buildable_health where object_id in (select distinct object_id from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null)));
delete from building_instances where object_id in (select distinct object_id from buildings where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-7 days') and owner_id not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null)));
delete from building_instances where object_id in (select distinct object_id from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null)));
delete from properties where object_id in (select distinct object_id from buildings where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-7 days') and object_id not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null)));
delete from properties where object_id in (select distinct object_id from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null)));
delete from actor_position where id in (select distinct object_id from buildings where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-7 days') and id not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null)));
delete from actor_position where id in (select distinct object_id from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null)));
delete from buildings where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-7 days') and guild is null);
delete from buildings where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null));
delete from item_properties where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-7 days') and owner_id not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null));
delete from item_properties where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null));
delete from item_inventory where owner_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-7 days') and owner_id not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null));
delete from item_inventory where owner_id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null));
delete from actor_position where id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-7 days') and id not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null));
delete from actor_position where id in (select guildid from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null));
delete from guilds where guildid not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null);
delete from character_stats where char_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-7 days') and guild is null);
delete from character_stats where char_id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-7 days') and guild not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null));
delete from characters where id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-7 days') and guild is null);
delete from characters where id in (select id from characters where lastTimeOnline < strftime('%s', 'now', '-7 days') and guild not in (select distinct guild from characters where lastTimeOnline > strftime('%s', 'now', '-7 days') and guild is not null));
insert into actor_position (class,map,id,x,y,z,sx,sy,sz,rx,ry,rz,rw) select 'BasePlayerChar_C', 'ConanSandbox', id, '-11875.3369140625','123886.0625', '-9016.935546875', '0.949999988079071', '0.949999988079071', '0.949999988079071', '1.87273170603776e-13', '1.7312404764977e-14', '0.092052161693573', '0.995754182338715' from characters where id in (select id from characters where id not in (select id from actor_position));
