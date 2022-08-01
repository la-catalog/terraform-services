# data "github_repositories" "la_catalog" {
#   query = "org:la-catalog"
# }

# resource "github_issue_label" "test_repo" {
#   for_each   = data.github_repositories.la_catalog.names
#   repository = each.key
#   name       = "bug"
#   color      = "d73a4a"
# }