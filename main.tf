
# ------------------------------------------------------------ #
#                   Setting up the localstack                  #
# ------------------------------------------------------------ #

# provider "aws" {
#   access_key                  = "test"
#   secret_key                  = "test"
#   region                      = "eu-north-1"
#   skip_credentials_validation = true
#   skip_metadata_api_check     = true
#   skip_requesting_account_id  = true

#   endpoints {
#     ec2            = "http://localhost:4566"
#     s3             = "http://localhost:4566"
#     iam            = "http://localhost:4566"
#     sts            = "http://localhost:4566"
#     lambda         = "http://localhost:4566"
#     apigateway     = "http://localhost:4566"
#     dynamodb       = "http://localhost:4566"
#     cloudwatch     = "http://localhost:4566"
#     logs           = "http://localhost:4566"
#     sqs            = "http://localhost:4566"
#     sns            = "http://localhost:4566"
#   }
# }

# ------------------------------------------------------------ #
#                     Setting up a real ec2                    #
# ------------------------------------------------------------ #

provider "aws" {
  region = "eu-north-1"
}

module "ec2" {
  source = "./modules/ec2"

  server_port = 80
# db_host     = module.db.db_endpoint    <== Output from my db module
  db_host     = "host.docker.internal"    # This is a special hostname that allows containers to access your host machine. Windows/macOS
  db_name     = "wordpress"
  username    = "admin"
  password    = "chelsea"
  vpc_id      = "vpc-0aa5a1fb481431b50"
  key_name    = "wordpress-challenge"         # 👈 This must match the key pair in AWS
  subnet_id   = "subnet-06cf4d44d41eff7c1" 
}

module "db" {
  source             = "./modules/db"
  instance_ec2_sg_id = module.ec2.ec2_sg_id
}


