### Create EC2 Profile and attach the IAM role to it ###
resource "aws_iam_instance_profile" "ec2_profile" {
  name       = "ec2_profile"
  role       = aws_iam_role.ec2_role.name
  depends_on = [aws_iam_role.ec2_role]
}

### Create IAM Role for the EC2 instances ###
resource "aws_iam_role" "ec2_role" {
  name               = "ec2_role"
  assume_role_policy = file("${path.module}/policies/ec2-role.json")
}

### Create and attach policy to the EC2 Role ###
resource "aws_iam_role_policy" "ec2_policy" {
  name   = "ec2-policy"
  role   = aws_iam_role.ec2_role.id
  policy = file("${path.module}/policies/ec2-policy.json")
}

### Create ssm policy to connect to the EC2 instnaces ###
resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ec2_role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
