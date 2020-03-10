########################################################
# Tags
########################################################

variable client_name {
  description = "(Required) - Name of the client"
  type        = string
}

variable environment {
  description = "(Required) - Name of the environment in which the resource is provisioned"
  type        = string
}

variable aws_region {
  description = "(Required) - If specified, the AWS region this bucket should reside in. Otherwise, the region used by the callee."
  type        = string
}

variable provisioning {
  description = "(Optional) - Is it manually provisioned or using terraform?"
  type        = string
  default     = "terraform"
}

variable defcon_level {
  description = "(Optional) - Level of distress!"
  type        = string
  default     = "0"
}

variable propagate_at_launch {
  description = "(Optional) - Propogate at launch"
  type        = bool
  default     = true
}

########################################################
# CloudFront
########################################################

# Top-Level Arguments

variable comment {
  type        = string
  description = "(Optional) - Any comments you want to include about the distribution."
  default     = "Managed by Terraform"
}

variable default_root_object {
  type        = string
  description = "(Optional) - The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL."
  default     = "index.html"
}

variable aliases {
  type        = list
  description = "(Optional) - Extra CNAMEs (alternate domain names), if any, for this distribution."
  default     = []
}

variable web_acl_id {
  type        = string
  description = "(Optional) - If you're using AWS WAF to filter CloudFront requests, the Id of the AWS WAF web ACL that is associated with the distribution. The WAF Web ACL must exist in the WAF Global (CloudFront) region and the credentials configuring this argument must have waf:GetWebACL permissions assigned."
  default     = ""
}

variable price_class {
  type        = string
  description = "(Optional) - The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100."
  default     = "PriceClass_All"
}

# Viewer Certificate Arguments

variable acm_certificate_arn {
  type        = string
  description = "The IAM certificate identifier of the custom viewer certificate for this distribution if you are using a custom domain. Specify this, acm_certificate_arn, or cloudfront_default_certificate."
  default     = ""
}

variable viewer_minimum_protocol_version {
  type        = string
  description = "The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections. Can only be set if cloudfront_default_certificate = false. One of SSLv3, TLSv1, TLSv1_2016, TLSv1.1_2016 or TLSv1.2_2018."
  default     = "TLSv1.1_2016"
}

# Logging Config Arguments

variable logging_enabled {
  type        = bool
  description = "(Optional) - Wether logging config enabled"
  default     = false
}

variable log_include_cookies {
  type        = bool
  description = "(Optional) - Specifies whether you want CloudFront to include cookies in access logs."
  default     = true
}

variable log_bucket_domain_name {
  type        = string
  description = "(Optional) - The Amazon S3 bucket to store the access logs in, for example, myawslogbucket.s3.amazonaws.com. Required if logging_enabled is true."
  default     = ""
}

variable log_prefix {
  type        = string
  description = "(Optional) - An optional string that you want CloudFront to prefix to the access log filenames for this distribution, for example, myprefix/."
  default     = "logs"
}

# Origin Arguments

variable origins {
  type        = list
  description = "(Required) - A list of the origin objects."
}

#### Origin Arguments Default Values

variable origin_ssl_protocols_default {
  type        = list
  description = "(Optional) - The SSL/TLS protocols that you want CloudFront to use when communicating with your origin over HTTPS."
  default     = ["TLSv1", "TLSv1.1", "TLSv1.2"]
}

variable origin_protocol_policy_default {
  type        = string
  description = "(Optional) - The origin protocol policy to apply to your origin."
  default     = "match-viewer"
}

variable origin_read_timeout_default {
  type        = number
  description = "(Optional) - The Custom Read timeout, in seconds. By default, AWS enforces a limit of 60."
  default     = 60
}

variable origin_keepalive_timeout_default {
  type        = number
  description = "(Optional) - The Custom KeepAlive timeout, in seconds. By default, AWS enforces a limit of 60."
  default     = 60
}

variable origin_http_port_default {
  type        = number
  description = "(Optional) - The HTTP port the custom origin listens on."
  default     = 80
}

variable origin_https_port_default {
  type        = number
  description = "(Optional) - The HTTPS port the custom origin listens on."
  default     = 443
}

# Cache Behavior Arguments

variable default_behavior_target_origin_id {
  type        = string
  description = "(Required) - The value of ID for the origin that you want CloudFront to route requests to when a request matches the path pattern either for a cache behavior or for the default cache behavior."
}

variable ordered_behaviors {
  type        = list
  description = "(Optional) - A list of the ordered behaviors"
  default     = []
}

#### Default Cache Behavior Arguments

variable cache_behavior_viewer_protocol_policy_default {
  type        = string
  description = "(Optional) - Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https."
  default     = "redirect-to-https"
}

variable cache_behavior_allowed_methods_default {
  type        = list
  description = "(Optional) - Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin."
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable cache_behavior_cached_methods_default {
  type        = list
  description = "(Optional) - Controls whether CloudFront caches the response to requests using the specified HTTP methods."
  default     = ["GET", "HEAD", "OPTIONS"]
}

variable cache_behavior_default_ttl_default {
  type        = number
  description = "(Optional) - The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header. Defaults to 1 day."
  default     = 86400
}

variable cache_behavior_min_ttl_default {
  type        = number
  description = "(Optional) - The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated. Defaults to 0 seconds."
  default     = 0
}

variable cache_behavior_max_ttl_default {
  type        = number
  description = "(Optional) - The maximum amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request to your origin to determine whether the object has been updated. Only effective in the presence of Cache-Control max-age, Cache-Control s-maxage, and Expires headers. Defaults to 365 days."
  default     = 31536000
}

#### Forwarded Values Arguments

variable cache_behavior_forwarded_values_query_string_default {
  type        = bool
  description = "(Optional) - Indicates whether you want CloudFront to forward query strings to the origin that is associated with this cache behavior."
  default     = false
}

variable cache_behavior_forwarded_values_headers_default {
  type        = list
  description = "(Optional) - Specifies the Headers, if any, that you want CloudFront to vary upon for this cache behavior. Specify * to include all headers."
  default     = []
}

#### #### Forwarded Values Arguments Cookies Arguments

variable cache_behavior_forwarded_values_cookies_forward_default {
  type        = string
  description = "(Optional) - Specifies whether you want CloudFront to forward cookies to the origin that is associated with this cache behavior. You can specify all, none or whitelist. If whitelist, you must include the subsequent whitelisted_names."
  default     = "none"
}

variable cache_behavior_forwarded_values_cookies_whitelisted_names_default {
  type        = list
  description = "(Optional) - If you have specified whitelist to forward, the whitelisted cookies that you want CloudFront to forward to your origin."
  default     = []
}

# Custom Error Response Arguments

variable custom_error_responses {
  type        = list
  description = "(Optional) - List of one or more custom error response element maps."
  default     = [{
    error_caching_min_ttl = 0
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
  }]
}

# Restrictions Arguments

variable geo_restriction_type {
  type        = string
  description = "(Optional) - The method that you want to use to restrict distribution of your content by country: none, whitelist, or blacklist."
  default     = "none"
}

variable geo_restriction_locations {
  type        = list
  description = "(Optional) - The ISO 3166-1-alpha-2 codes for which you want CloudFront either to distribute your content (whitelist) or not distribute your content (blacklist)."
  default     = []
}
