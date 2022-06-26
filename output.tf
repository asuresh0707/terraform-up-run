output "public_ip" {
  description = "the ip of ec2 instance"
  value = aws_instance.app.public_ip
}