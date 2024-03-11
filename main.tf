# Impostazione del provider per utilizzare una regione europea ad emissioni zero
provider "google" {
  region = "europe-west4"
}

# Modulo per la configurazione di Cloud Run per la gestione dell'anagrafica
module "cloudrun_anagrafica" {
  source = "../modules/cloudrun"
  name   = "anagrafica-service"
  # Aggiornamento della location al data center europeo ad emissioni zero
  location = "europe-west4"
  service_account = var.service_account
  run_image = "europe-west4-docker.pkg.dev/cloudrun/container/anagrafica"
  run_envs = {
    "API_URL" = "https://api.masterdata.org/user"
  }
}

# Risorse di Cloud Storage con location aggiornata a "europe-west4"
resource "google_storage_bucket" "archive_bucket" {
  name                        = "archive"
  # Aggiornamento della location al data center europeo ad emissioni zero
  location                    = "europe-west4"
  force_destroy               = true
  uniform_bucket_level_access = true
  storage_class               = "STANDARD"
}