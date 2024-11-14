{% set step = STEP or "" %}
{%- if steps["007-dns"] %}

org                      = "{{ ORG }}"
app                      = "{{ APP }}"
env                      = "{{ ENV }}"
shared_credentials_files = "{{ aws["AWS_SHARED_CREDENTIALS_FILE"] }}"
shared_config_files      = "{{ aws["AWS_CONFIG_FILE"] }}"
region                   = "{{ steps["007-dns"]["AWS_REGION"] }}"
profile                  = "{{ steps["007-dns"]["AWS_PROFILE"] }}"

{%- endif %}
