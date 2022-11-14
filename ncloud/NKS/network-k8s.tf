# 네트워킹 설정을 다룬다
# vpc : 10.0.0.0/16
# kr-1 리전에 public, private, private(lb) 로 총 3개의 subnet을 구성한다.
# kr-2 리전도 이하 동일

# nks는 bastion에서 접근하도록 하며, bastion에는 public으로 구성하여 client를 받는다.


resource "ncloud_vpc" "vpc" {
  name = "kubernetes-vpc"
  ipv4_cidr_block = "10.0.0.0/16"
}

resource "ncloud_subnet" "k8s-bastion-kr1" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = "10.0.11.0/24"
  zone           = "KR-1"
  network_acl_no = ncloud_vpc.vpc.default_network_acl_no
  subnet_type    = "PUBLIC"
  name           = "k8s-bastion-kr1"
}

resource "ncloud_subnet" "k8s-cluster-kr1" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = "10.0.12.0/24"
  zone           = "KR-1"
  network_acl_no = ncloud_vpc.vpc.default_network_acl_no
  subnet_type    = "PRIVATE"
  name           = "k8s-cluster-kr1"
}

resource "ncloud_subnet" "k8s-lb-kr1" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = "10.0.13.0/24"
  zone           = "KR-1"
  network_acl_no = ncloud_vpc.vpc.default_network_acl_no
  subnet_type    = "PRIVATE"
  usage_type     = "LOADB"
  name           = "k8s-lb-kr1"
}

resource "ncloud_subnet" "k8s-bastion-kr2" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = "10.0.21.0/24"
  zone           = "KR-2"
  network_acl_no = ncloud_vpc.vpc.default_network_acl_no
  subnet_type    = "PUBLIC"
  name           = "k8s-bastion-kr2"
}

resource "ncloud_subnet" "k8s-cluster-kr2" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = "10.0.22.0/24"
  zone           = "KR-2"
  network_acl_no = ncloud_vpc.vpc.default_network_acl_no
  subnet_type    = "PRIVATE"
  name           = "k8s-cluster-kr2"
}

resource "ncloud_subnet" "k8s-lb-kr2" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = "10.0.23.0/24"
  zone           = "KR-2"
  network_acl_no = ncloud_vpc.vpc.default_network_acl_no
  subnet_type    = "PRIVATE"
  usage_type     = "LOADB"
  name           = "k8s-lb-kr2"
}
