# link : https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/resources/block_storage
# bool 타입으로 envtype을 받게되는데, true값이면 3, false값이면 1개의 block storage를 생성한다.



resource "ncloud_block_storage" "storage" {
    server_instance_no = ncloud_server.server.id
    name = "storage-${count.index}"
    count = var.envtype ? 3 : 1
    size = "10"
}

variable "envtype" {
  type = bool
}

resource "ncloud_server" "server" {
  subnet_no                 = ncloud_subnet.test.id
  name                      = "my-tf-server"
  server_image_product_code = "SW.VSVR.OS.LNX64.CNTOS.0703.B050"
  login_key_name            = ncloud_login_key.loginkey.key_name
}
