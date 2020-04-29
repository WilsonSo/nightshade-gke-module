resource "google_project_iam_custom_role" "cluster" {
  role_id = "cluster"
  title   = "cluster Role"

  project    = var.project
  depends_on = [google_project_service.iam]

  permissions = [
    "compute.addresses.list",
    "compute.instances.addAccessConfig",
    "compute.instances.deleteAccessConfig",
    "compute.instances.get",
    "compute.instances.list",
    "compute.projects.get",
    "container.clusters.get",
    "container.clusters.list",
    "resourcemanager.projects.get",
    "compute.networks.useExternalIp",
    "compute.subnetworks.useExternalIp",
    "compute.addresses.use",
    "resourcemanager.projects.get",
    "storage.objects.get",
    "storage.objects.list",
  ]
}

# cluster service account
resource "google_service_account" "cluster" {

  account_id = "cluster-serviceaccount"
  project    = var.project
  depends_on = [google_project_iam_custom_role.cluster]
}

resource "google_project_iam_member" "iam_member_cluster" {

  role       = "projects/${var.project}/roles/cluster"
  project    = var.project
  member     = "serviceAccount:cluster-serviceaccount@${var.project}.iam.gserviceaccount.com"
  depends_on = [google_service_account.cluster]
}

resource "google_project_iam_custom_role" "kubeip" {
  role_id = "kubeip"
  title   = "kubeip Role"

  project    = var.project
  depends_on = [google_project_service.iam]


  permissions = [
    "compute.addresses.list",
    "compute.instances.addAccessConfig",
    "compute.instances.deleteAccessConfig",
    "compute.instances.get",
    "compute.instances.list",
    "compute.projects.get",
    "container.clusters.get",
    "container.clusters.list",
    "resourcemanager.projects.get",
    "compute.networks.useExternalIp",
    "compute.subnetworks.useExternalIp",
    "compute.addresses.use",
  ]
}

# kubeip service account
resource "google_service_account" "kubeip" {
  account_id = "kubeip-serviceaccount"
  project    = var.project
  depends_on = [google_project_iam_custom_role.kubeip]
}

resource "google_project_iam_member" "iam_member_kubeip" {

  role       = "projects/${var.project}/roles/kubeip"
  project    = var.project
  member     = "serviceAccount:kubeip-serviceaccount@${var.project}.iam.gserviceaccount.com"
  depends_on = [google_service_account.kubeip]
}
