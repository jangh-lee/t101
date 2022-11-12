resource "ncloud_init_script" "init" {
  name    = "http-script"
  content = "#!/bin/bash \n yum install -y httpd \n systemctl start httpd"
}

resource "ncloud_server" "server" {
  subnet_no                 = ncloud_subnet.subnet.id
  name                      = "dev-web-server"
  server_image_product_code = "SW.VSVR.OS.LNX64.CNTOS.0703.B050"
  login_key_name            = ncloud_login_key.login_key.key_name
  init_script_no            = ncloud_init_script.init.id
}

resource "ncloud_public_ip" "public_ip" {
  server_instance_no = ncloud_server.server.id
}
