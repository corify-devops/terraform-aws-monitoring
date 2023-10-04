module "this" {
  source     = "../../"
  topic_name = "cloudwatch-alarm-test"

  email_addresses = ["alarms-test@example.com"]
  phone_numbers   = ["+000000000"]
  web_endpoints   = [sensitive("https://example.com/")]
  slack_webhooks = [{
    hook_url = "test-slack-hook-url"
    channel  = "test-slack-channel"
    username = "test-slack-username"
  }]
  servicenow_webhooks = [{
    domain = "test-servicenow-domain"
    path   = "test-servicenow-path"
    user   = "test-servicenow-user"
    pass   = "test-servicenow-pass"
  }]

  fallback_email_addresses = ["test@dasmeta.com"]
  fallback_phone_numbers   = ["+000000000"]
  fallback_web_endpoints   = ["https://example.com/"]
  lambda_failed_alert = {
    period    = 60
    threshold = 1
    equation  = "gte"
    statistic = "sum"
  }
}
