from typing import Dict
from typing import List, Any, Optional
from pydantic import BaseModel
from pydantic_yaml import YamlModel



class Gcp(BaseModel):
    GOOGLE_APPLICATION_CREDENTIALS: str



class Dns(BaseModel):
    tld_domain: str
    env_subdomain: str
    fqn_env_subdomain: str
    domain: str


class Versions(BaseModel):
    infra_version: str
    terraform_version: str

class Step(YamlModel):
    AWS_REGION: Optional[str]
    AWS_PROFILE: Optional[str]
    gcp_region: Optional[str]

class Env(YamlModel):
    ENV: str
    ORG_APP: str
    app: Any
    github_owner_org: str
    dns: Dns
    versions: Versions
    steps: Dict[str, Step]
    microservices: Any



class CnfModel(YamlModel):
    """The base configuration model

    Description:
        This data model describes how the data in configuration files should look like
    """

    env: Env
