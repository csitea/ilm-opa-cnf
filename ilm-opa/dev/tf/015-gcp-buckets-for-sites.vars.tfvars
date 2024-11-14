

org                                                = "str"
app                                                = "mmp"
env                                                = "dev"
gcp_region                                         = "europe-north1"
gcp_project                                        = "ilm-opa-dev"
gcp_zone                                           = "europe-north1-c"
bucket_name                                        = "ilm-opa-dev-tf-state"
wpb_fqdn                                           = "dev.opa.ilmatarbrain.com"
buckets                                            = [{"enable_versioning": true, "force_destroy": true, "location": "europe-north1", "name": "ilm-opa-dev-site", "storage_class": "Standard"}]
