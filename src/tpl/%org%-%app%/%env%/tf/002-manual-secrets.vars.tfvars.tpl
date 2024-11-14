{%- if steps["002-manual-secrets"] %}

org                                                = "{{ ORG }}"
app                                                = "{{ APP }}"
env                                                = "{{ ENV }}"
gcp_project                                        = "{{ gcp["gcp_project"] }}"
bucket_name                                        = "{{ gcp["state_bucket"] }}"


{%- for key, value in steps["002-manual-secrets"].items() %}
{%- set key_length = 50 - (key | length) %}
  {{ key }} {{ "=" | indent( key_length, True) }} {{ value | tojson}}
{%- endfor %}

{%- else %}
# This file is empty because there is no configuration block for this step in
# Running this step will cause terraform to error before init.
{%- endif %}
