module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.1.1"

  name = "single-instance"

  ami                    = "ami-0705384c0b33c194c"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "module-project"
    Environment = "dev"
  }
}