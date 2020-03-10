output "cf_id" {
  type        = string
  description = "ID of AWS CloudFront distribution"
  value       = "${aws_cloudfront_distribution.default.id}"
}

output "cf_arn" {
  type        = string
  description = "ID of AWS CloudFront distribution"
  value       = "${aws_cloudfront_distribution.default.arn}"
}

output "cf_aliases" {
  type        = string
  description = "Extra CNAMEs of AWS CloudFront"
  value       = "${var.aliases}"
}

output "cf_domain_name" {
  type        = string
  description = "Domain name corresponding to the distribution"
  value       = "${aws_cloudfront_distribution.default.domain_name}"
}
