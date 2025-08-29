output "aws_instance_public_ip" {
    description = "The public IP address of the EC2 instance"
    value = aws_instance.nginxserver.public_ip
}

output "aws_instance_public_ip" {
    description = "The URL to access the Nginx server"
    value = "http://${aws_instace.nginxserver.public_ip}"
}