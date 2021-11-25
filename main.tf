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
  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 90
    lb_protocol       = "http"
  }
}

output "lboutput" {
  value = aws_elb.bar.dns_name
}
output "op2" {
  value = aws_instance.soumachine[0].public_ip
}
