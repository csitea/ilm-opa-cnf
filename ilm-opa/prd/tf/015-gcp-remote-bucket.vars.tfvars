

org                                                = "str"
app                                                = "mmp"
env                                                = "prd"
gcp_region                                         = "europe-north1"
gcp_project                                        = "ilm-opa-prd"
gcp_zone                                           = "europe-north1-a"
bucket_name                                        = "ilm-opa-prd-tf-state"
buckets                                            = [{"enable_versioning": false, "force_destroy": true, "location": "europe-north1", "name": "ilm-opa-prd-db", "storage_class": "Standard"}]
