resource "google_sql_database_instance" "default" {
  name             = "flask-mysql-db"
  database_version = "MYSQL_8_0"
  region           = var.region

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled = true

      authorized_networks {
        name  = "allow flask vm"
        value = "0.0.0.0/0"
      }
    }
  }
}

resource "google_project_service" "sqladmin" {
  project = var.project_id
  service = "sqladmin.googleapis.com"
}

resource "google_sql_database" "app_db" {
  instance = google_sql_database_instance.default.name
  name     = var.db_name
}

resource "google_sql_user" "app_user" {
  instance    = google_sql_database_instance.default.name
  name        = var.db_username
  password_wo = var.db_password
}
