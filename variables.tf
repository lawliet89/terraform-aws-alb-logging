variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default = {
    Terraform = "true"
  }
}

variable "l7_logging_bucket" {
  description = "Name of L7 Access Logging bucket to create"
  type        = string
  default     = ""
}

variable "l7_logging_expiration" {
  description = "Expiration lifecycle rules for access logging bucket"
  type = list(object({
    enabled = bool

    date = optional(string) # Specifies the date after which you want the corresponding action to take effect.
    days = optional(number) # Specifies the number of days after object creation when the specific rule action takes effect.
    id   = optional(string)
  }))
  default = [
    {
      id      = "Delete2Years"
      enabled = true
      days    = 730
    },
  ]
}

variable "l7_logging_transition" {
  description = "L7 Logging class storage transitions"
  type = list(object({
    enabled       = bool
    storage_class = string

    date = optional(string) # Specifies the date after which you want the corresponding action to take effect.
    days = optional(number) # Specifies the number of days after object creation when the specific rule action takes effect.
    id   = optional(string)
  }))
  default = [
    {
      id            = "IA"
      enabled       = true
      days          = 30
      storage_class = "STANDARD_IA"
    },
    {
      id            = "Glacier"
      enabled       = true
      days          = 365
      storage_class = "GLACIER"
    },
  ]
}

variable "l7_object_lock_enabled" {
  description = "Enable Object Lock on the bucket. See https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lock.html"
  type        = bool
  default     = false
}

variable "l7_object_default_retention" {
  description = "Object lock default retention configuration. See https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lock-overview.html"
  type = object({
    mode  = string
    days  = optional(number)
    years = optional(number)
  })
  default = {
    mode  = "GOVERNANCE"
    years = 2
  }
}

variable "l7_logging_bucket_policy" {
  description = "Bucket policy document, if any"
  type        = string
  default     = ""
}

variable "l7_logging_prefixes" {
  description = "Prefixes you want to include in the resource policy for the bucket"
  type        = list(string)
  default     = ["alb"]
}

variable "l7_public_block" {
  description = "Public block settings for S3 bucket"
  type = object({
    block_public_acls   = bool
    block_public_policy = bool

    ignore_public_acls      = bool
    restrict_public_buckets = bool
  })
  default = {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }
}
