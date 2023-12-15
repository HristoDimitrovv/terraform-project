resource "aws_ssm_patch_baseline" "amazon" {
  name             = "${var.prefix}-amazon-patching-baseline"
  approved_patches = var.approved_patches_am
  rejected_patches = var.rejected_patches_am
  operating_system = "AMAZON_LINUX_2"

  approval_rule {
    approve_after_days = 7
    compliance_level   = "HIGH"

    patch_filter {
      key    = "PRODUCT"
      values = var.product_versions_am
    }

    patch_filter {
      key    = "CLASSIFICATION"
      values = var.patch_classification_am
    }

    patch_filter {
      key    = "SEVERITY"
      values = var.patch_severity_am
    }
  }
}

resource "aws_ssm_patch_group" "amazon" {
  baseline_id = aws_ssm_patch_baseline.amazon.id
  patch_group = "${var.prefix}-install-patchgroup-am"
}