resource "kubernetes_namespace" "namespace" {
  count = length(var.namespaces)

  metadata {
    annotations = {
      name = var.namespaces[count.index].name
    }

    name = var.namespaces[count.index].name
  }
}

resource "kubernetes_resource_quota" "namespace_quota" {
  count = length(var.namespaces)

  metadata {
    name      = "${var.namespaces[count.index].name}-quota"
    namespace = kubernetes_namespace.namespace[count.index].metadata[0].name
  }

  spec {
    hard = {
      pods                          = var.namespaces[count.index].quota.pods
      "limits.cpu"                  = var.namespaces[count.index].quota.limit_cpu
      "limits.memory"               = var.namespaces[count.index].quota.limit_memory
      "requests.cpu"                = var.namespaces[count.index].quota.request_cpu
      "requests.memory"             = var.namespaces[count.index].quota.request_memory
      persistentvolumeclaims        = var.namespaces[count.index].quota.pvc
      "requests.storage"            = var.namespaces[count.index].quota.limit_storage
      "services.nodeports"          = "0"
      "services.loadbalancers"      = "0"
      "count/daemonsets.apps"       = "0"
      "count/daemonsets.extensions" = "0"
      "count/jobs.batch"            = "0"
    }
  }
}

resource "kubernetes_limit_range" "default" {
  count = length(var.namespaces)

  metadata {
    name      = "${var.namespaces[count.index].name}-limits"
    namespace = kubernetes_namespace.namespace[count.index].metadata[0].name
  }

  spec {
    limit {
      type = "Container"

      default = {
        cpu    = var.namespaces[count.index].limit_range.limit_cpu
        memory = var.namespaces[count.index].limit_range.limit_memory
      }

      default_request = {
        cpu    = var.namespaces[count.index].limit_range.request_cpu
        memory = var.namespaces[count.index].limit_range.request_memory
      }
    }
  }
}

resource "kubernetes_role" "user_role" {
  count = length(var.namespaces)

  metadata {
    name      = "${kubernetes_namespace.namespace[count.index].metadata[0].name}-role"
    namespace = kubernetes_namespace.namespace[count.index].metadata[0].name
  }

  rule {
    api_groups = [""]
    resources  = ["*"]
    verbs      = ["*"]
  }

  rule {
    api_groups = ["apps"]
    resources  = ["*"]
    verbs      = ["*"]
  }

  rule {
    api_groups = ["batch"]
    resources  = ["*"]
    verbs      = ["*"]
  }

  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["*"]
    verbs      = ["*"]
  }

  rule {
    api_groups = ["autoscaling"]
    resources  = ["*"]
    verbs      = ["*"]
  }

  rule {
    api_groups = ["middlewares"]
    resources  = ["*"]
    verbs      = ["*"]
  }

  rule {
    api_groups = ["metrics.k8s.io"]
    resources  = ["pods"]
    verbs      = ["get", "list"]
  }

  rule {
    api_groups = ["cert-manager.io"]
    resources = [
      "certificates",
      "certificaterequests",
      "issuers"
    ]
    verbs = [
      "get",
      "list",
      "watch",
      "create",
      "update",
      "patch",
      "delete"
    ]
  }

  rule {
    api_groups = ["discovery.k8s.io"]
    resources  = ["endpointslices"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["kafka.strimzi.io"]
    resources = [
      "kafkas",
      "kafkatopics",
      "kafkaconnects",
      "kafkamirrormakers",
      "kafkabridges",
      "kafkaconnector",
      "kafkamirrormaker2s"
    ]
    verbs = [
      "get",
      "list",
      "watch",
      "create",
      "update",
      "patch",
      "delete"
    ]
  }
}

resource "kubernetes_role_binding" "user_binding" {
  count = length(var.namespaces)

  metadata {
    name      = "${kubernetes_namespace.namespace[count.index].metadata[0].name}-role-binding"
    namespace = kubernetes_namespace.namespace[count.index].metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = var.namespaces[count.index].user
    namespace = "kube-system"
  }

  role_ref {
    kind      = "Role"
    name      = kubernetes_role.user_role[count.index].metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }
}
