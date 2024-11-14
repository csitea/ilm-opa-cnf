{%- set step = STEP or "" %}
  {%- if step == "007-dns" %}

{%- if steps[step]["state_bucket"] is defined and steps[step]["state_bucket"] != "" %}
  {%- set state_bucket = steps[step]["state_bucket"] %}
{%- else %}
  {%- set state_bucket = ORG + '-' + APP + '-' + ENV + '.' + step + '-remote-bucket.tf-st' %}
{%- endif %}

bucket = "{{ gcp["state_bucket"] }}"
prefix = "terraform/{{ STEP }}"

{%- endif %}
