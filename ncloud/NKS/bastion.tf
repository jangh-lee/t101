resource "ncloud_server" "bastion-server" {
  subnet_no                 = ncloud_subnet.k8s-bastion-kr1.id
  name                      = "k8s-bastion"
  server_image_product_code = "SW.VSVR.OS.LNX64.CNTOS.0703.B050"
  login_key_name            = ncloud_login_key.loginkey.key_name
}

resource "ncloud_public_ip" "public_ip" {
  server_instance_no = "ncloud_server.bastion-server.id"
}
