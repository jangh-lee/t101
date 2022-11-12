# subnet
resource "ncloud_subnet" "lb" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = "10.0.2.0/24"
  zone           = "KR-2"
  network_acl_no = ncloud_vpc.vpc.default_network_acl_no
  subnet_type    = "PRIVATE"
  name           = "subnet-02"
  usage_type     = "LOADB"
}


# load balancer
resource "ncloud_lb" "test" {
  name = "tf-lb-test"
  network_type = "PUBLIC"
  type = "APPLICATION"
  subnet_no_list = [ncloud_subnet.lb.subnet_no]
}


# listener
resource "ncloud_lb_listener" "test" {
  load_balancer_no = ncloud_lb.test.id
  protocol         = "HTTP"
  port             = 80
  target_group_no  = ncloud_lb_target_group.test.id
}

# target group
resource "ncloud_lb_target_group" "test" {
  name        = "tf-tg-test"
  target_type = "VSVR"
  vpc_no      = ncloud_vpc.vpc.vpc_no
  protocol    = "HTTP"
  port        = 80
  health_check {
    protocol       = "HTTP"
    port           = 80
    url_path       = "/"
    http_method    = "GET"
    cycle          = 30
    up_threshold   = 2
    down_threshold = 2
  }
  algorithm_type = "RR"
}
