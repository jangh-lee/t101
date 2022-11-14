# NAT Gateway
# nks가 private 서브넷에 위치함에 따라 outbound traffic을 활성화해주어야 docker hub와 소통이 가능하다.

# 추후 과제로는 private subnet zone에 harbor 혹은 nexus3를 구축해서 outbound를 열어주지 않아도 가능하도록 구성하겠다.



resource "ncloud_nat_gateway" "nat_gateway" {
  vpc_no      = ncloud_vpc.vpc.id
  zone        = "KR-1"
  // below fields is optional
  name        = "k8s-nat-gw"
  description = "This is NAT GW for kubernetes cluster."
}
