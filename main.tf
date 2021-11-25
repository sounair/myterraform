provider "aws" {
  region     = "us-west-2"

}
resource aws_instance soumachine{
    ami=var.ami_name
    count= 3
    instance_type=var.type_name
    
}
resource "aws_elb" "bar" {
    name         = "soulb"
    availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
     instances =aws_instance.soumachine.*.id
}    

output "lboutput" {
  value = aws_elb.bar.dns_name
}
