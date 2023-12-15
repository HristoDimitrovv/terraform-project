resource "aws_ssm_patch_baseline" "ubuntu" {
  name             = "${var.prefix}-patch-baseline-ub"
  approved_patches = var.approved_patches_ub
  rejected_patches = var.rejected_patches_ub
  operating_system = "UBUNTU"

  approval_rule {
    approve_after_days = 7
    compliance_level   = "HIGH"

    patch_filter {
      key    = "PRODUCT"
      values = var.product_versions_ub
    }

    patch_filter {
      key    = "SECTION"
      values = var.patch_classification_ub
    }

    patch_filter {
      key    = "PRIORITY"
      values = var.patch_severity_ub
    }
  }
}

resource "aws_ssm_patch_group" "ubuntu" {
  baseline_id = aws_ssm_patch_baseline.ubuntu.id
  patch_group = "${var.prefix}-install-patchgroup-ub"
}