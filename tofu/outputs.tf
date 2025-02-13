output "istaroth_ip" {
  description = "istaroth instance's public IP"
  value       = aws_instance.istaroth_instance.public_ip
}
