

org                                                = "str"
app                                                = "mmp"
env                                                = "prd"
gcp_region                                         = "europe-north1"
gcp_project                                        = "ilm-opa-prd"
gcp_zone                                           = "europe-north1-a"
bucket_name                                        = "ilm-opa-prd-tf-state"
wpb_fqdn                                           = "opa.ilmatarbrain.com"
buckets                                            = [{"enable_versioning": true, "force_destroy": true, "location": "europe-north1", "name": "ilm-opa-prd-site", "storage_class": "Standard"}]
