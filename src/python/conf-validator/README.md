# Configuration Validator

This Python project is a command-line tool for validating YAML configuration files using Pydantic models. It uses the `typer` library for the command-line interface, `rich` for console logging, and `pydantic_yaml` for Pydantic models with YAML parsing support.

## Code Structure

Here is an overview of the main components in the code:

- `validate.py`: This is the main script that contains the command-line interface for the tool. It defines a `validate` command that takes a YAML file and an environment as arguments, and validates the file using the appropriate Pydantic model based on the environment.

- `Classes/EnvEnum.py`: This file defines an enumeration `ModelType` for the environment types. Each environment type is mapped to a corresponding Pydantic model.

- `EnvModels.py`: This file contains the definitions of the Pydantic models for different environments.

## Models

The configuration file is expected to follow the structure defined by the Pydantic models:

- `Env`: Represents the root of the configuration, and includes fields such as `ENV`, `ORG`, `APP`, `app`, `github_owner_org`, `DNS`, `RDS`, `versions`, `aws`, `steps`, and `microservices`.

- `CnfModel`: This is the top-level model which includes the `env` field of type `Env`.

- Other models: `Aws`, `rds`, `dns`, `Versions`, define the structure of corresponding sections in the configuration.

## Usage

To validate a configuration file, run the `validate.py` script with the `validate` command, followed by the file and environment:

```bash
python validate.py validate --file <path-to-yaml-file> --env <environment>
```

Replace `<path-to-yaml-file>` with the path to the YAML file you want to validate, and `<environment>` with the environment type (`prd`, `tst`, `stg`, `dev`).

If the file is valid, the script will print a success message. If the file is not valid, it will print an error message detailing the validation errors.

## Note

Please ensure that the input YAML configuration files adhere to the defined Pydantic models for successful validation.
