# this is going to create dashboard with container widgets
module "basic-dashboard-with-text" {
  source = "../../"
  name   = "Basic-Dashboard-with-text"
  rows = [
    [
      {
        type : "text/title"
        text : "Row 1 / col 1"
      }
    ],
    [
      {
        type : "container/cpu",
        period : 300,
        container : "nginx",
        cluster : "test-cluster"
      },
      {
        type : "container/memory",
        period : 300,
        container : "nginx",
        cluster : "test-cluster"
      },
      # {
      #   type : "container/memory",
      #   container : "nginx",
      # },
      # {
      #   type : "container/restarts",
      #   container : "nginx",
      # },
      # {
      #   type : "container/network",
      #   container : "nginx",
      # }
    ],
    [
      {
        type : "text/title"
        text : "Row 2 / col 1"
      }
    ]
  ]
}
