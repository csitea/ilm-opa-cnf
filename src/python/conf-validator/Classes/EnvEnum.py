from enum import Enum
from EnvModels import TstEnv, DevEnv, PrdEnv, AllEnv, StgEnv


class ModelType(Enum):
    prd = PrdEnv
    tst = TstEnv
    stg = StgEnv
    dev = DevEnv
    all = AllEnv
