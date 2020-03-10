output "cf_id" {
  description = "ID of AWS CloudFront distribution"
  value       = "${aws_cloudfront_distribution.default.id}"
}

output "cf_arn" {
  description = "ID of AWS CloudFront distribution"
  value       = "${aws_cloudfront_distribution.default.arn}"
}

output "cf_aliases" {
  description = "Extra CNAMEs of AWS CloudFront"
  value       = "${var.aliases}"
}

output "cf_domain_name" {
  description = "Domain name corresponding to the distribution"
  value       = "${aws_cloudfront_distribution.default.domain_name}"
}
