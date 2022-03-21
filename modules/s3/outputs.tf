output "aws_s3_bucket_name" {
  description = "Bucket name"
  value       = "${aws_s3_bucket.testbucket.arn}"
}