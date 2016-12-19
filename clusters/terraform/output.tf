output "ip" {
    value = ["${aws_instance.db.0.public_ip}"]
}
