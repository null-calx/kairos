output "istaroth_ip" {
  description = "istaroth instance's public IP"
  value       = local.public_ip
}

output "images_found" {
  description = "number of core images found"
  # value       = data.oci_core_images.instance_image.images
  value       = length(data.oci_core_images.instance_image.images)
}
