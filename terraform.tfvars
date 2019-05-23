cloudwatch_event_target_input = "{ \"tags\": [ { \"Key\": \"Environment\", \"Values\": [\"lab\"] } ] }"

schedule_stop_resources  = "cron(00 09 * * ? *)"
schedule_start_resources = "cron(00 19 * * ? *)"