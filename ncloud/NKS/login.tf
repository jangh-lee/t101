resource "local_file" "private_key" {
  filename = "./${ncloud_login_key.login_key.key_name}.pem"
  content = "ncloud_login_key.login_key.private_key"
  file_permission = "0400"
}
