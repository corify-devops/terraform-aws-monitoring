module "base" {
  source = "../../base"

  platform        = var.platform
  data_source_uid = var.data_source_uid

  coordinates = var.coordinates

  name = "Network > Out"

  defaults = {
    MetricNamespace   = "ContainerInsights"
    ClusterName       = var.cluster
    Namespace         = var.namespace
    PodName           = var.container
    accountId         = var.account_id
    anomaly_detection = var.anomaly_detection
  }

  period = var.period

  metrics = [
    { MetricName = "pod_network_tx_bytes", color = "#e377c2", label = "Out", anomaly_detection = var.anomaly_detection }
  ]
}
