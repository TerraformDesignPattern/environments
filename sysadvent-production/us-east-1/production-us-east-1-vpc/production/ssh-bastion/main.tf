module "environment" {
  source = "../"
}

module "ami_image_id" {
  source = "git@github.com:TerraformDesignPattern/packer.git?ref=4ddd5d059c6f501c0a0bfb56b7ceec3c2515dcc0//terraform-ami-module"

  aws_region = "${module.environment.aws_region}"
}

module "bastion" {
  source = "git@github.com:TerraformDesignPattern/bastionhost.git"

  aws_account = "${module.environment.aws_account}"
  aws_region = "${module.environment.aws_region}"
  environment_name = "${module.environment.environment_name}"
  hostname = "${var.hostname}"
  image_id = "${module.ami_image_id.base_image_id}"
  vpc_name = "${module.environment.vpc_name}"
}
