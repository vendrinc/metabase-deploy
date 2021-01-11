\set logname `echo "'$LOGNAME'"`
begin;
delete from pulse_card;
delete from pulse_channel_recipient;
delete from pulse_channel;
delete from pulse;
update metabase_database set details = '{
  "let-user-control-scheduling" : false,
  "password" : "",
  "dbname" : "warehouse_development",
  "tunnel-enabled" : false,
  "host" : "localhost",
  "user" : "' || :logname || '",
  "port" : 5432,
  "additional-options" : null,
  "ssl" : false
}'
where name = 'Warehouse';

update setting set value = 'http://localhost:9000' where key = 'site-url';
delete from setting where key = 'slack-token';

commit;
