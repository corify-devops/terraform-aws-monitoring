module "this" {
  source                          = "../../"
  name                            = "dev"
  sns_topic_name                  = "alarm-dev"
  webhook_url                     = ""
  application_channel_webhook_url = ""
  enable_log_base_metrics         = true
  fallback_email_addresses        = []
  fallback_phone_numbers          = []
  health_checks = [
    {
      host = "dasmeta.com"
      path = "/"
    }
  ]
  log_base_metrics = [
    {
      name           = "container_exception_error_fail_crash_critical"
      filter         = "{$.log = *error* || $.log = *fail* || $.log = *crash* || $.log = *critical* || $.log = *exception*}"
      log_group_name = "eks-dev"
    },
  ]
  application_channel_alerts = [
    {
      name      = "Too many exception/fail/crash/error/critical in logs"
      source    = "LogGroupFilter/container_exception_error_fail_crash_critical_dev"
      statistic = "sum"
      threshold = 100
      period    = 600
      filters   = {}
    },
  ]
  alerts = [
    // Restarts
    {
      name   = "Corify frontend has too many restarts (eks-dev)"
      source = "ContainerInsights/pod_number_of_container_restarts"
      filters = {
        PodName     = "test-application",
        ClusterName = "eks-dev",
        Namespace   = "test-app"
      }
      period    = 86400
      statistic = "sum"
      threshold = 2
    },
  ]
  eks_monitroing_dashboard = [
    [
      {
        type : "text/title"
        text : "Nodes"
      }
    ],
  ]
  application_monitroing_dashboard = [
    [
      {
        width         = 24
        height        = 8
        type          = "sla-slo-sli",
        balancer_name = "alb-dev"
        region        = "eu-central-1"
      }
    ],
  ]

}
