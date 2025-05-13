# Simple Gallery App in Flask Using Terraform With GCP

## Project Overview

This is a simple photo gallery web app built with **Flask**, deployed on a **Google Cloud Platform (GCP)** virtual machine, and provisioned using **Terraform**. The app stores uploaded images in a GCS bucket and metadata in a Cloud SQL database.

Infrastructure includes:
- GCE instance running a Flask server
- Cloud SQL for mySQL with Private IP
- GCS bucket for image storage
- VPC, firewall rules, service networking, and IAM bindings

---

## Setup Instructions

1. **Bundle the Flask server into a deployable script**
   ```sh
   cd gallery
   ./bundle.sh
   ```

2. **Create the project using terraform**
   ```sh
   cd ..
   terraform init
   terraform apply
   ```

## Architecture Diagram

```mermaid
flowchart TD
    %% Node definitions
    google_compute_firewall_allow_http["google_compute_firewall.allow_http"]
    google_compute_firewall_allow_ssh["google_compute_firewall.allow_ssh"]
    google_compute_global_address_private_ip_address["google_compute_global_address.private_ip_address"]
    google_compute_instance_flask_vm["google_compute_instance.flask-vm"]
    google_compute_network_vpc_network["google_compute_network.vpc_network"]
    google_compute_subnetwork_default["google_compute_subnetwork.default"]
    google_project_service_sqladmin["google_project_service.sqladmin"]
    google_service_networking_connection_private_vpc_connection["google_service_networking_connection.private_vpc_connection"]
    google_sql_database_app_db["google_sql_database.app_db"]
    google_sql_database_instance_default["google_sql_database_instance.default"]
    google_sql_user_app_user["google_sql_user.app_user"]
    google_storage_bucket_flask_app_bucket["google_storage_bucket.flask_app_bucket"]
    google_storage_bucket_iam_member_public_access["google_storage_bucket_iam_member.public_access"]
    random_uuid_uuid["random_uuid.uuid"]

    %% Reversed Edges (simulate bottom-up)
    google_compute_network_vpc_network --> google_compute_firewall_allow_http
    google_compute_network_vpc_network --> google_compute_firewall_allow_ssh
    google_compute_network_vpc_network --> google_compute_global_address_private_ip_address
    google_compute_subnetwork_default --> google_compute_instance_flask_vm
    google_sql_database_instance_default --> google_compute_instance_flask_vm
    google_storage_bucket_flask_app_bucket --> google_compute_instance_flask_vm
    google_compute_network_vpc_network --> google_compute_subnetwork_default
    google_compute_global_address_private_ip_address --> google_service_networking_connection_private_vpc_connection
    google_sql_database_instance_default --> google_sql_database_app_db
    google_service_networking_connection_private_vpc_connection --> google_sql_database_instance_default
    google_sql_database_instance_default --> google_sql_user_app_user
    random_uuid_uuid --> google_storage_bucket_flask_app_bucket
    google_storage_bucket_flask_app_bucket --> google_storage_bucket_iam_member_public_access
```


# Validation Report

## Terraform Apply Output
```sh
Apply complete! Resources: 10 added, 0 changed, 0 destroyed.

Outputs:

bucket_name = "a0121092-1812-4f83-f40b-2b1893d875db"
bucket_url = "gs://a0121092-1812-4f83-f40b-2b1893d875db"
vm_external_ip = "35.193.151.161"
```

## GCP Console Resources
![alt text](vm_instance.png)
![alt text](sql_instance.png)
![alt text](storage_instance.png)
![alt text](network_instance.png)

## Working Application Interface
![alt text](photo_gallery.png)

## Database Connection Test
![alt text](photos_validation.png)
![alt text](users_validation.png)

## Metrics
 - Deployment Time: ~25 Minutes
 - Resource Costs(Monthly): $35.47
   - Compute: $20.56
   - SQL: $9.37
   - Storage: $1.90
   - Networking: $3.65 