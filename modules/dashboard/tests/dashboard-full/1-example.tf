locals {
  account_id         = "133737826969"
  zone_name          = "query.me"
  balancer_name      = "query-me-prod"
  cdn_id             = "E1KW6B6H80852Y"
  container_1        = "query-me-app-superset-helm"
  target_group_arn_1 = "arn:aws:elasticloadbalancing:eu-central-1:133737826969:targetgroup/k8s-default-querymea-04013fb00d/334f3b8b6d24c764"
  healthcheck_id_1   = "9d51e128-be63-4a0d-a782-8784d572893a"
  rds                = "query-me-prod"
  cluster            = "prod-6"
}

module "basic-dashboard-with-text" {
  source = "../../"
  name   = "dashboard-full-test"

  defaults = {
    cluster : local.cluster
  }
  rows = [
    [
      { type = "sla-slo-sli", width : 8, balancer_name = local.balancer_name }
    ],
    [
      { type : "text/title-with-link", text : "DNS Zone", link_to_jump = "https://us-east-1.console.aws.amazon.com/route53/v2/hostedzones?region=eu-central-1#ListRecordSets/Z08123863M3ECTRR0CNC5" }
    ],
    [
      { type : "dns/queries-gauge", zone_name : local.zone_name },
      { type : "dns/queries-chart", width : 18, zone_name : local.zone_name },
    ],
    [
      { type : "text/title-with-link", text : "CDN (CloudFront)", link_to_jump = "https://us-east-1.console.aws.amazon.com/cloudfront/v3/home?region=us-east-1#/distributions/E30ILTOR2J789A" }
    ],
    [
      { type : "cloudfront/requests", distribution : local.cdn_id },
      { type : "cloudfront/errors", distribution : local.cdn_id },
      { type : "cloudfront/error-rate", distribution : local.cdn_id },
      { type : "cloudfront/traffic-bytes", distribution : local.cdn_id },
    ],
    [
      { type : "text/title-with-link", text : "Load Balancer (ALB)", link_to_jump = "https://eu-central-1.console.aws.amazon.com/ec2/home?region=eu-central-1#LoadBalancer:loadBalancerArn=arn:aws:elasticloadbalancing:eu-central-1:133737826969:loadbalancer/app/query-me-prod/a64fd40a8da2216e;tab=listeners" }
    ],
    [
      { type : "balancer/request-count", accountId : local.account_id, balancer_name : local.balancer_name, anomaly_detection : false },
      { type : "balancer/2xx", accountId : local.account_id, balancer_name : local.balancer_name, anomaly_detection : false },
      { type : "balancer/4xx", accountId : local.account_id, balancer_name : local.balancer_name, anomaly_detection : false },
      { type : "balancer/5xx", accountId : local.account_id, balancer_name : local.balancer_name, anomaly_detection : false },
    ],
    [
      { type : "balancer/all-requests", accountId : local.account_id, balancer_name : local.balancer_name },
      { type : "balancer/unhealthy-request-count", accountId : local.account_id, balancer_name : local.balancer_name, anomaly_detection : true },
      { type : "balancer/error-rate", accountId : local.account_id, balancer_name : local.balancer_name, anomaly_detection = false },
      { type : "balancer/connection-issues", accountId : local.account_id, balancer_name : local.balancer_name, anomaly_detection = false },
    ],
    [
      { type : "balancer/response-time", accountId : local.account_id, balancer_name : local.balancer_name },
      { type : "balancer/traffic", accountId : local.account_id, balancer_name : local.balancer_name },
    ],
    [
      { type : "text/title", text : "Superset" }
    ],
    [
      { type : "container/request-count", container : local.container_1, target_group_arn : local.target_group_arn_1 },
      { type : "container/all-requests", container : local.container_1, target_group_arn : local.target_group_arn_1, balancer_name : local.balancer_name },
      { type : "container/error-rate", container : local.container_1, target_group_arn : local.target_group_arn_1, balancer_name : local.balancer_name },
      { type : "container/health-check", container : local.container_1, target_group_arn : local.target_group_arn_1, balancer_name : local.balancer_name },
    ],
    [
      { type : "container/cpu", container : local.container_1 },
      { type : "container/memory", container : local.container_1 },
      { type : "container/network-in", container : local.container_1 },
      { type : "container/network-out", container : local.container_1 },
    ],
    [
      { type : "container/external-health-check", container : local.container_1, healthcheck_id : local.healthcheck_id_1 },
      { type : "container/replicas", container : local.container_1 },
      { type : "container/restarts", container : local.container_1 },
      { type : "container/response-time", container : local.container_1, target_group_arn : local.target_group_arn_1, balancer_name : local.balancer_name },
      # { type : "container/network", container : local.container_1 },
    ],
    [
      { type : "block/rds", name : "query-me-prod" }
    ],
    [
      { type : "text/title-with-link", text : "RDS (query-me-prod)", link_to_jump = "https://eu-central-1.console.aws.amazon.com/rds/home?region=eu-central-1#database:id=query-me-prod;is-cluster=false;tab=connectivity" }
    ],
    [
      { type : "rds/free-storage", rds_name : local.rds },
      { type : "rds/connections", rds_name : local.rds, db_max_connections_count : 100 },
      { type : "rds/performance", rds_name : local.rds },
      { type : "rds/network", rds_name : local.rds },
    ],
    [
      { type : "rds/cpu", rds_name : local.rds, anomaly_detection : true },
      { type : "rds/iops", rds_name : local.rds },
      { type : "rds/swap", rds_name : local.rds },
      { type : "rds/disk-latency", rds_name : local.rds },
    ]
  ]
}
