{%- if steps["015-gcp-remote-bucket"] %}

org                                                = "{{ ORG }}"
app                                                = "{{ APP }}"
env                                                = "{{ ENV }}"
gcp_region                                         = "{{ gcp["gcp_region"] }}"
gcp_project                                        = "{{ gcp["gcp_project"] }}"
gcp_zone                                           = "{{ gcp["gcp_zone"] }}"
bucket_name                                        = "{{ gcp["state_bucket"] }}"


{%- for key, value in steps["015-gcp-remote-bucket"].items() %}
{%- set key_length = 50 - (key | length) %}
{{ key }} {{ "=" | indent( key_length, True) }} {{ value | tojson}}
{%- endfor %}

{%- else %}
# This file is empty because there is no configuration block for this step in
# Running this step will cause terraform to error before init.
{%- endif %}
