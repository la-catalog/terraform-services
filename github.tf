data "github_repositories" "la_catalog" {
  query = "org:la-catalog"
}

###### Issues labels ######
# The organization is configured to always create repositories with default issues,
# so only uncomment when a new issue needs to be added to every repository.
# After executing, comment it and run:
#       terraform state rm github_issue_label.label
# 
# resource "github_issue_label" "label" {
#   for_each   = toset(data.github_repositories.la_catalog.names)
#   repository = each.key
#   name       = "bug"
#   color      = "d73a4a"
#   description = "Something isn't working"
# }