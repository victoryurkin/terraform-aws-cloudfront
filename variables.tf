########################################################
# Tags
########################################################

variable client_name {
  description = "Name of the client"
  type        = string
}

variable environment {
  description = "Name of the environment in which the resource is provisioned"
  type        = string
}

variable aws_region {
  description = "(Optional) If specified, the AWS region this bucket should reside in. Otherwise, the region used by the callee."
  type        = string
}

variable provisioning {
  description = "Is it manually provisioned or using terraform?"
  type        = string
  default     = "terraform"
}

variable defcon_level {
  description = "Level of distress!"
  type        = string
  default     = "0"
}

variable propagate_at_launch {
  description = "Propogate at launch"
  type        = bool
  default     = true
}

########################################################
# General
########################################################

variable "enabled" {
  default     = "true"
  description = "Set to false to prevent the module from creating any resources"
}

variable "acm_certificate_arn" {
  description = "Existing ACM Certificate ARN"
  default     = ""
}

variable "aliases" {
  type        = list
  default     = []
  description = "List of aliases. CAUTION! Names MUSTN'T contain trailing `.`"
}

variable "custom_error_response" {
  # http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/custom-error-pages.html#custom-error-pages-procedure
  # https://www.terraform.io/docs/providers/aws/r/cloudfront_distribution.html#custom-error-response-arguments
  description = "(Optional) - List of one or more custom error response element maps"
  type    = list
  default = []
}

variable "web_acl_id" {
  description = "(Optional) - Web ACL ID that can be attached to the Cloudfront distribution"
  default     = ""
}

########################################################
# Origin object
########################################################

variable "origins" {
  type = list(object)
  description = "List of origin objects"
}

variable "default_origin_ssl_protocols" {
  type        = list(string)
  description = "The SSL/TLS protocols that you want CloudFront to use when communicating with your origin over HTTPS"  
  default     = ["TLSv1", "TLSv1.1", "TLSv1.2"]
}

variable "default_origin_protocol_policy" {
  type        = string
  description = "The origin protocol policy to apply to your origin. One of http-only, https-only, or match-viewer"
  default     = "match-viewer"
}

variable "default_origin_read_timeout" {
  type        = number
  description = "The Custom Read timeout, in seconds. By default, AWS enforces a limit of 60. But you can request an increase."
  default     = 60
}

variable "default_origin_keepalive_timeout" {
  type        = number
  description = "The Custom KeepAlive timeout, in seconds. By default, AWS enforces a limit of 60. But you can request an increase."
  default     = 60
}

variable "default_origin_http_port" {
  type        = number
  description = "The HTTP port the custom origin listens on"
  default     = 80
}

variable "default_origin_https_port" {
  type        = number
  description = "The HTTPS port the custom origin listens on"
  default     = 443
}




variable "compress" {
  description = "(Optional) Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header (default: false)"
  default     = "false"
}

variable "is_ipv6_enabled" {
  default     = "true"
  description = "State of CloudFront IPv6"
}

variable "default_root_object" {
  default     = "index.html"
  description = "Object that CloudFront return when requests the root URL"
}

variable "comment" {
  default     = "Managed by Terraform"
  description = "Comment for the origin access identity"
}

variable "logging_enabled" {
  default     = "false"
  description = "Wether logging config enabled"
}

variable "log_include_cookies" {
  default     = "false"
  description = "Include cookies in access logs"
}

variable "log_bucket_domain_name" {
  default     = ""
  description = "S3 bucket domain name for logs"
}

variable "log_prefix" {
  default     = ""
  description = "Path of logs in S3 bucket"
}

variable "forward_query_string" {
  default     = "false"
  description = "Forward query strings to the origin that is associated with this cache behavior"
}

variable "forward_headers" {
  description = "Specifies the Headers, if any, that you want CloudFront to vary upon for this cache behavior. Specify `*` to include all headers."
  type        = list
  default     = []
}

variable "forward_cookies" {
  description = "Specifies whether you want CloudFront to forward cookies to the origin. Valid options are all, none or whitelist"
  default     = "none"
}

variable "forward_cookies_whitelisted_names" {
  type        = list
  description = "List of forwarded cookie names"
  default     = []
}

variable "price_class" {
  default     = "PriceClass_100"
  description = "Price class for this distribution: `PriceClass_All`, `PriceClass_200`, `PriceClass_100`"
}

variable "viewer_minimum_protocol_version" {
  description = "(Optional) The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections."
  default     = "TLSv1.1_2016"
}

variable "viewer_protocol_policy" {
  description = "allow-all, redirect-to-https"
  default     = "redirect-to-https"
}

variable "allowed_methods" {
  type        = list
  default     = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
  description = "List of allowed methods (e.g. ` GET, PUT, POST, DELETE, HEAD`) for AWS CloudFront"
}

variable "cached_methods" {
  type        = list
  default     = ["GET", "HEAD"]
  description = "List of cached methods (e.g. ` GET, PUT, POST, DELETE, HEAD`)"
}

variable "default_ttl" {
  default     = "60"
  description = "Default amount of time (in seconds) that an object is in a CloudFront cache"
}

variable "min_ttl" {
  default     = "0"
  description = "Minimum amount of time that you want objects to stay in CloudFront caches"
}

variable "max_ttl" {
  default     = "31536000"
  description = "Maximum amount of time (in seconds) that an object is in a CloudFront cache"
}

variable "geo_restriction_type" {
  # e.g. "whitelist"
  default     = "none"
  description = "Method that use to restrict distribution of your content by country: `none`, `whitelist`, or `blacklist`"
}

variable "geo_restriction_locations" {
  type = list
  # e.g. ["US", "CA", "GB", "DE"]
  default     = []
  description = "List of country codes for which  CloudFront either to distribute content (whitelist) or not distribute your content (blacklist)"
}

variable "cache_behavior" {
  type        = list
  description = "An ordered list of cache behaviors resource for this distribution. List from top to bottom in order of precedence. The topmost cache behavior will have precedence 0."
  default     = []
}