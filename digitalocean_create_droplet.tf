# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "${var.do_token}"
}

# Create a new tag
resource "digitalocean_tag" "learning_terraform_tag" {
  name = "learning_terraform_tag"
}

# Create a new web droplet running ubuntu in the LON1(London-1) region
resource "digitalocean_droplet" "web" {
  image    = "ubuntu-18-04-x64"
  name     = "learning-terraform-droplet"
  region   = "lon1"
  size     = "1gb"
  ssh_keys = [22083138]
  tags     = ["${digitalocean_tag.learning_terraform_tag.id}"]

  provisioner "local-exec" {
    command = "echo ${digitalocean_droplet.web.ipv4_address} > ip_address.txt"
  }
}
