module "base" {
  source = "../../base"

  coordinates = var.coordinates

  name = "Requests"

  # stats
  stat   = "Sum"
  period = var.period

  defaults = {
    MetricNamespace = "AWS/ApplicationELB"
    LoadBalancer    = var.balancer
    accountId       = var.account_id
  }

  metrics = [
    { MetricName : "RequestCount", "color" = "#2ca02c", anomaly_detection = var.anomaly_detection },
  ]
}
