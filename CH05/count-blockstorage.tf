# link : https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/resources/block_storage
# count를 통해서 block storage 3개를 생성한다.

resource "ncloud_block_storage" "storage" {
    server_instance_no = ncloud_server.server.id
    name = "storage-${count.index}"
    count = 3
    size = "10"
}




resource "ncloud_server" "server" {
  subnet_no                 = ncloud_subnet.test.id
  name                      = "my-tf-server"
  server_image_product_code = "SW.VSVR.OS.LNX64.CNTOS.0703.B050"
  login_key_name            = ncloud_login_key.loginkey.key_name
}
