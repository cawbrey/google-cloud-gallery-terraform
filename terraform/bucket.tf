resource "google_storage_bucket" "flask_app_bucket" {
  name = "${random_uuid.uuid.result}"
  location = var.region

  storage_class = "STANDARD"

  force_destroy = true
}

resource "random_uuid" "uuid" {}

# Output the bucket name for use in your app or further configuration
output "bucket_name" {
  value = google_storage_bucket.flask_app_bucket.name
}

output "bucket_url" {
  value = google_storage_bucket.flask_app_bucket.url
}

resource "google_storage_bucket_iam_member" "public_access" {
  bucket = google_storage_bucket.flask_app_bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}
