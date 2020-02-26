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

variable "comment" {
  type        = string
  default     = "Managed by Terraform"
  description = "(Optional) - Comment for the origin access identity"
}

variable "default_root_object" {
  type        = string
  default     = "index.html"
  description = "(Optional) - Object that CloudFront return when requests the root URL"
}

variable "aliases" {
  type        = list
  default     = []
  description = "(Optional) - List of aliases. CAUTION! Names MUSTN'T contain trailing `.`"
}

variable "web_acl_id" {
  type        = string
  description = "(Optional) - Web ACL ID that can be attached to the Cloudfront distribution"
  default     = ""
}

variable "price_class" {
  type = string
  description = "(Optional) - The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100"
  default = "PriceClass_All"
}

########################################################
# Viewer Certificate
########################################################

variable "acm_certificate_arn" {
  type        = string
  description = "(Optional) - Existing ACM Certificate ARN"
  default     = ""
}

variable "viewer_minimum_protocol_version" {
  type        = string
  description = "(Optional) - The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections."
  default     = "TLSv1.1_2016"
}

########################################################
# Logging Config
########################################################

variable "logging_enabled" {
  type        = string
  default     = "true"
  description = "(Optional) - Wether logging config enabled"
}

variable "log_include_cookies" {
  type        = string
  default     = "true"
  description = "(Optional) - Include cookies in access logs"
}

variable "log_bucket_domain_name" {
  type        = string
  default     = ""
  description = "(Optional) - S3 bucket domain name for logs"
}

variable "log_prefix" {
  type        = string
  default     = "logs"
  description = "(Optional) - Path of logs in S3 bucket"
}

########################################################
# Origins
########################################################

variable "origins" {
  type = list
  description = "(Required) - List of origin objects"
}

variable "origin_ssl_protocols_default" {
  type        = list
  description = "(Optional) - The SSL/TLS protocols that you want CloudFront to use when communicating with your origin over HTTPS"  
  default     = ["TLSv1", "TLSv1.1", "TLSv1.2"]
}

variable "origin_protocol_policy_default" {
  type        = string
  description = "(Optional) - The origin protocol policy to apply to your origin. One of http-only, https-only, or match-viewer"
  default     = "match-viewer"
}

variable "origin_read_timeout_default" {
  type        = number
  description = "(Optional) - The Custom Read timeout, in seconds. By default, AWS enforces a limit of 60. But you can request an increase."
  default     = 60
}

variable "origin_keepalive_timeout_default" {
  type        = number
  description = "(Optional) - The Custom KeepAlive timeout, in seconds. By default, AWS enforces a limit of 60. But you can request an increase."
  default     = 60
}

variable "origin_http_port_default" {
  type        = number
  description = "(Optional) - The HTTP port the custom origin listens on"
  default     = 80
}

variable "origin_https_port_default" {
  type        = number
  description = "(Optional) - The HTTPS port the custom origin listens on"
  default     = 443
}

########################################################
# Behaviors
########################################################

variable "default_behavior_target_origin_id" {
  type        = string
  description = "(Required) - Default behavior target origin id"
}

variable "ordered_behaviors" {
  type        = list
  description = "(Optional) - List of ordered behaviors"
  default     = []
}

variable "cache_behavior_viewer_protocol_policy_default" {
  type        = string
  description = "(Optional) - allow-all, redirect-to-https"
  default     = "redirect-to-https"
}

variable "cache_behavior_allowed_methods_default" {
  type        = list
  description = "(Optional) - List of allowed methods (e.g. ` GET, PUT, POST, DELETE, HEAD`) for AWS CloudFront"
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable "cache_behavior_cached_methods_default" {
  type        = list
  description = "(Optional) - List of cached methods (e.g. ` GET, PUT, POST, DELETE, HEAD`)"
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable "cache_behavior_forwarded_values_query_string_default" {
  type        = string
  description = "(Optional) - Forward query strings to the origin that is associated with this cache behavior"
  default     = "false"
}

variable "cache_behavior_forwarded_values_cookies_forward_default" {
  type        = string
  description = "(Optional) - Specifies whether you want CloudFront to forward cookies to the origin. Valid options are all, none or whitelist"
  default     = "none"
}

variable "cache_behavior_forwarded_values_cookies_whitelisted_names_default" {
  type        = list
  description = "(Optional) - List of forwarded cookie names"
  default     = []
}

variable "cache_behavior_default_ttl_default" {
  type        = number
  description = "(Optional) - Default amount of time (in seconds) that an object is in a CloudFront cache"
  default     = 86400
}

variable "cache_behavior_min_ttl_default" {
  type        = number
  description = "(Optional) - Minimum amount of time that you want objects to stay in CloudFront caches"
  default     = 0
}

variable "cache_behavior_max_ttl_default" {
  type        = number
  description = "(Optional) - Maximum amount of time (in seconds) that an object is in a CloudFront cache"
  default     = 31536000
}

########################################################
# Custom Error
########################################################

variable "custom_error_responses" {
  type        = list
  description = "(Optional) - List of one or more custom error response element maps"
  default     = [{
    error_caching_min_ttl = 0
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
  }]
}

########################################################
# Restrictions
########################################################

variable "geo_restriction_type" {
  type        = string
  description = "(Optional) - Method that use to restrict distribution of your content by country: `none`, `whitelist`, or `blacklist`"
  default     = "none"
}

variable "geo_restriction_locations" {
  type        = list
  description = "(Optional) - List of country codes for which  CloudFront either to distribute content (whitelist) or not distribute your content (blacklist)"
  default     = []
}
