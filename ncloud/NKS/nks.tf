# 필터의 효용성 고민중

data "ncloud_nks_versions" "version" {
  filter {
    name = "value"
    values = ["1.23"]
    regex = true
  }
}

resource "ncloud_login_key" "loginkey" {
  key_name = "sample-login-key"
}


resource "ncloud_nks_cluster" "cluster" {
  cluster_type                = "SVR.VNKS.STAND.C002.M008.NET.SSD.B050.G002"
  k8s_version                 = data.ncloud_nks_versions.version.versions.0.value
  login_key_name              = ncloud_login_key.loginkey.key_name
  name                        = "sample-cluster"
  vpc_no                      = ncloud_vpc.vpc.id
  subnet_no_list              = [ ncloud_subnet.k8s-cluster-kr1.id ]
  lb_private_subnet_no        = ncloud_subnet.k8s-lb-kr1.id
  kube_network_plugin         = "cilium"
  zone                        = "KR-1"
  log {
    audit = true
  }
}


resource "ncloud_nks_node_pool" "node_pool" {
  cluster_uuid   = ncloud_nks_cluster.cluster.uuid
  node_pool_name = "sample-node-pool"
  node_count     = 2
  product_code   = "SVR.VSVR.STAND.C002.M008.NET.SSD.B050.G002"
  subnet_no      = ncloud_subnet.k8s-cluster-kr1.id
  autoscale {
    enabled = true
    min = 1
    max = 2
  }
}
